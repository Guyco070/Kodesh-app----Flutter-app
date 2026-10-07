import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/helpers/app_logger.dart';
import 'package:kodesh_app/models/hebcal_holiday.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/calendar_day_cell.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/calendar_month_header.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/calendar_weekday_row.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/holiday_day_sheet.dart';
import 'package:provider/provider.dart';

/// Month grid of holidays. Weeks start on Sunday (Jewish calendar convention)
/// and all month/weekday names follow the app's locale.
///
/// Each month is fetched on its own when it is shown and cached for the life
/// of the widget, so paging is never blocked by data that hasn't loaded yet.
/// The neighbouring months are prefetched in the background.
class MonthlyCalendarView extends StatefulWidget {
  const MonthlyCalendarView({
    super.key,
    required this.initialMonth,
    this.searchText = '',
  });

  final DateTime initialMonth;

  /// Only holidays whose name contains this text are shown (case-insensitive).
  final String searchText;

  /// The grid never grows wider than this, so cells stay compact on desktop.
  static const double maxGridWidth = 720;

  @override
  State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
}

class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
  late DateTime _currentMonth;

  final Map<DateTime, List<HebcalHoliday>> _cache = {};
  final Set<DateTime> _loading = {};
  final Set<DateTime> _failed = {};

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(
      widget.initialMonth.year,
      widget.initialMonth.month,
    );
    // setState isn't allowed during initState, so start loading after the
    // first frame.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _ensureMonthLoaded(_currentMonth, prefetchNeighbours: true),
    );
  }

  DateTime _monthOffset(DateTime month, int delta) =>
      DateTime(month.year, month.month + delta);

  Future<void> _ensureMonthLoaded(
    DateTime month, {
    bool prefetchNeighbours = false,
  }) async {
    if (!mounted) return;
    if (!_cache.containsKey(month) && !_loading.contains(month)) {
      setState(() {
        _loading.add(month);
        _failed.remove(month);
      });
      try {
        final holidays = await context.read<Events>().fetchHolidaysInRange(
          month,
          _monthOffset(month, 1).subtract(const Duration(days: 1)),
        );
        if (!mounted) return;
        setState(() => _cache[month] = holidays);
      } catch (e, st) {
        logger.w(
          'Failed to load holidays for $month',
          error: e,
          stackTrace: st,
        );
        if (!mounted) return;
        setState(() => _failed.add(month));
      } finally {
        if (mounted) setState(() => _loading.remove(month));
      }
    }
    if (prefetchNeighbours && mounted) {
      _ensureMonthLoaded(_monthOffset(month, -1));
      _ensureMonthLoaded(_monthOffset(month, 1));
    }
  }

  void _shiftMonth(int delta) {
    setState(() => _currentMonth = _monthOffset(_currentMonth, delta));
    _ensureMonthLoaded(_currentMonth, prefetchNeighbours: true);
  }

  Map<int, List<HebcalHoliday>> _buildDayMap(List<HebcalHoliday> holidays) {
    final query = widget.searchText.trim().toLowerCase();
    final map = <int, List<HebcalHoliday>>{};
    for (final h in holidays) {
      if (h.date.year != _currentMonth.year ||
          h.date.month != _currentMonth.month) {
        continue;
      }
      if (query.isNotEmpty &&
          !h.title.toLowerCase().contains(query) &&
          !h.hebrew.contains(query)) {
        continue;
      }
      map.putIfAbsent(h.date.day, () => []).add(h);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final localeTag = locale.toLanguageTag();
    final languageCode = locale.languageCode;

    final isLoading = _loading.contains(_currentMonth);
    final hasFailed = _failed.contains(_currentMonth);
    final dayMap = _buildDayMap(_cache[_currentMonth] ?? const []);

    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        _monthOffset(_currentMonth, 1).subtract(const Duration(days: 1)).day;
    // DateTime.weekday: 1=Mon..7=Sun; Sunday-first grid needs Sun=0.
    final startOffset = firstDay.weekday % 7;
    final now = DateTime.now();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: MonthlyCalendarView.maxGridWidth,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const horizontalPadding = 8.0;
            final cellWidth =
                (constraints.maxWidth - horizontalPadding * 2) / 7;
            // Cells are a bit taller than wide on phones (room for two
            // holiday labels) and shorter than wide on desktop.
            final cellHeight = math.max(64.0, math.min(cellWidth * 1.2, 96.0));
            final labelFontSize = (cellWidth / 7).clamp(10.0, 12.5);
            final dayFontSize = (cellWidth / 4.5).clamp(13.0, 16.0);

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                children: [
                  CalendarMonthHeader(
                    title: DateFormat.yMMMM(localeTag).format(_currentMonth),
                    onPrev: () => _shiftMonth(-1),
                    onNext: () => _shiftMonth(1),
                  ),
                  SizedBox(
                    height: 3,
                    child: isLoading ? const LinearProgressIndicator() : null,
                  ),
                  const SizedBox(height: 4),
                  CalendarWeekdayRow(localeTag: localeTag),
                  const SizedBox(height: 4),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisExtent: cellHeight,
                    ),
                    itemCount: startOffset + daysInMonth,
                    itemBuilder: (context, index) {
                      if (index < startOffset) return const SizedBox.shrink();
                      final day = index - startOffset + 1;
                      final dayHolidays = dayMap[day] ?? const [];
                      final date = DateTime(
                        _currentMonth.year,
                        _currentMonth.month,
                        day,
                      );
                      return CalendarDayCell(
                        day: day,
                        holidays: dayHolidays,
                        languageCode: languageCode,
                        isToday:
                            now.year == date.year &&
                            now.month == date.month &&
                            now.day == date.day,
                        dayFontSize: dayFontSize,
                        labelFontSize: labelFontSize,
                        onTap:
                            dayHolidays.isEmpty
                                ? null
                                : () => showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  builder:
                                      (_) => HolidayDaySheet(
                                        date: date,
                                        holidays: dayHolidays,
                                      ),
                                ),
                      );
                    },
                  ),
                  if (hasFailed)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Text(appLocalizations.apiErrorMessage),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () => _ensureMonthLoaded(_currentMonth),
                            child: Text(appLocalizations.retry),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
