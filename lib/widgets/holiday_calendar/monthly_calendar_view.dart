import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/hebcal_holiday.dart';

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
    final dayMap = _buildDayMap();
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    // weekday: 1=Mon..7=Sun, we want Sun=0
    final startOffset = (firstDay.weekday % 7);

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Month navigation header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _canGoPrev
                    ? () => setState(() {
                          _currentMonth = DateTime(
                            _currentMonth.year,
                            _currentMonth.month - 1,
                          );
                        })
                    : null,
              ),
              Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _canGoNext
                    ? () => setState(() {
                          _currentMonth = DateTime(
                            _currentMonth.year,
                            _currentMonth.month + 1,
                          );
                        })
                    : null,
              ),
            ],
          ),
        ),
        // Day-of-week headers (Sun..Sat)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: colorScheme.onSurface.withAlpha(153),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 4),
        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.75,
          ),
          itemCount: startOffset + daysInMonth,
          itemBuilder: (context, index) {
            if (index < startOffset) return const SizedBox.shrink();
            final day = index - startOffset + 1;
            final dayHolidays = dayMap[day] ?? [];
            final isToday = DateTime.now().year == _currentMonth.year &&
                DateTime.now().month == _currentMonth.month &&
                DateTime.now().day == day;

            return GestureDetector(
              onTap: dayHolidays.isEmpty
                  ? null
                  : () => _showHolidayDetails(context, day, dayHolidays),
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: isToday
                    ? BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      )
                    : null,
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday ? colorScheme.onPrimaryContainer : null,
                      ),
                    ),
                    ...dayHolidays.take(2).map(
                          (h) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: 1,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: h.isMajor
                                  ? colorScheme.primary.withAlpha(204)
                                  : colorScheme.secondary.withAlpha(153),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              h.hebrew,
                              style: TextStyle(
                                fontSize: 7,
                                color: h.isMajor
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                    if (dayHolidays.length > 2)
                      Text(
                        '+${dayHolidays.length - 2}',
                        style: TextStyle(
                          fontSize: 7,
                          color: colorScheme.onSurface.withAlpha(153),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showHolidayDetails(
    BuildContext context,
    int day,
    List<HebcalHoliday> holidays,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('d MMMM yyyy').format(
                DateTime(_currentMonth.year, _currentMonth.month, day),
              ),
              style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...holidays.map(
              (h) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.star,
                  color: h.isMajor ? Colors.blue : Colors.grey,
                ),
                title: Text(h.hebrew, textAlign: TextAlign.right),
                subtitle: Text(h.title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
