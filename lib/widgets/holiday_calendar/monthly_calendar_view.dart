import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/hebcal_holiday.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/calendar_day_cell.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/calendar_month_header.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/calendar_weekday_row.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/holiday_day_sheet.dart';

/// Month grid of holidays. Weeks start on Sunday (Jewish calendar convention)
/// and all month/weekday names follow the app's locale.
class MonthlyCalendarView extends StatefulWidget {
  const MonthlyCalendarView({
    super.key,
    required this.holidays,
    required this.initialMonth,
    required this.minDate,
    required this.maxDate,
  });

  final List<HebcalHoliday> holidays;
  final DateTime initialMonth;
  final DateTime minDate;
  final DateTime maxDate;

  /// The grid never grows wider than this, so cells stay compact on desktop.
  static const double maxGridWidth = 720;

  @override
  State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
}

class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(
      widget.initialMonth.year,
      widget.initialMonth.month,
    );
  }

  @override
  void didUpdateWidget(MonthlyCalendarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.holidays != widget.holidays) {
      final newMin = DateTime(widget.minDate.year, widget.minDate.month);
      if (_currentMonth.isBefore(newMin)) {
        _currentMonth = newMin;
      }
    }
  }

  bool get _canGoPrev {
    final prev = DateTime(_currentMonth.year, _currentMonth.month - 1);
    final minMonth = DateTime(widget.minDate.year, widget.minDate.month);
    return !prev.isBefore(minMonth);
  }

  bool get _canGoNext {
    final next = DateTime(_currentMonth.year, _currentMonth.month + 1);
    final maxMonth = DateTime(widget.maxDate.year, widget.maxDate.month);
    return !next.isAfter(maxMonth);
  }

  void _shiftMonth(int delta) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + delta);
    });
  }

  Map<int, List<HebcalHoliday>> _buildDayMap() {
    final map = <int, List<HebcalHoliday>>{};
    for (final h in widget.holidays) {
      if (h.date.year == _currentMonth.year &&
          h.date.month == _currentMonth.month) {
        map.putIfAbsent(h.date.day, () => []).add(h);
      }
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localeTag = locale.toLanguageTag();
    final languageCode = locale.languageCode;

    final dayMap = _buildDayMap();
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
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
                    onPrev: _canGoPrev ? () => _shiftMonth(-1) : null,
                    onNext: _canGoNext ? () => _shiftMonth(1) : null,
                  ),
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
