import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/search_filter_bar.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view.dart';
import 'package:provider/provider.dart';

enum _ViewMode { list, monthly }

class HolidayCalendarScreen extends StatefulWidget {
  const HolidayCalendarScreen({super.key});

  static const String routeName = '/holiday_calendar';

  @override
  State<HolidayCalendarScreen> createState() => _HolidayCalendarScreenState();
}

class _HolidayCalendarScreenState extends State<HolidayCalendarScreen> {
  bool _isLoading = false;
  _ViewMode _viewMode = _ViewMode.list;

  late DateTime _dateFrom;
  late DateTime _dateTo;

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _dateFrom = DateTime.now();
    _dateTo = DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
    _loadHolidays();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHolidays() async {
    setState(() => _isLoading = true);
    await Provider.of<Events>(context, listen: false)
        .fetchAnnualHolidays(startDate: _dateFrom, endDate: _dateTo);
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _pickDateRange() async {
    final appLocalizations = AppLocalizations.of(context)!;
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(start: _dateFrom, end: _dateTo),
      helpText: appLocalizations.selectDateRange,
    );
    if (picked != null) {
      setState(() {
        _dateFrom = picked.start;
        _dateTo = picked.end;
      });
      _loadHolidays();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final events = Provider.of<Events>(context);

    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.holidayCalendarMenu),
      body: Column(
        children: [
          _DateRangeRow(
            dateFrom: _dateFrom,
            dateTo: _dateTo,
            onTap: _pickDateRange,
            fromLabel: appLocalizations.dateRangeFrom,
            toLabel: appLocalizations.dateRangeTo,
          ),
          SearchFilterBar(
            controller: _searchController,
            hintText: appLocalizations.search,
            onChanged: (val) => setState(() => _searchText = val),
          ),
          _ViewToggle(
            viewMode: _viewMode,
            listLabel: appLocalizations.listView,
            monthlyLabel: appLocalizations.monthlyView,
            onChanged: (mode) => setState(() => _viewMode = mode),
          ),
          Expanded(
            child: _buildBody(appLocalizations, events),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AppLocalizations appLocalizations, Events events) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (events.annualHolidaysError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appLocalizations.apiErrorMessage),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadHolidays,
              child: Text(appLocalizations.retry),
            ),
          ],
        ),
      );
    }

    final allHolidays = events.annualHolidays ?? [];
    final filtered = allHolidays.where((h) {
      final inRange =
          !h.date.isBefore(_dateFrom) && !h.date.isAfter(_dateTo);
      if (!inRange) return false;
      if (_searchText.isEmpty) return true;
      final q = _searchText.toLowerCase();
      return h.title.toLowerCase().contains(q) ||
          h.hebrew.contains(_searchText);
    }).toList();

    if (filtered.isEmpty) {
      return Center(child: Text(appLocalizations.noSearchResults));
    }

    if (_viewMode == _ViewMode.monthly) {
      return SingleChildScrollView(
        child: MonthlyCalendarView(
          holidays: filtered,
          initialMonth: _dateFrom,
          minDate: _dateFrom,
          maxDate: _dateTo,
        ),
      );
    }

    final dateFormat = DateFormat('d MMMM yyyy');
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final holiday = filtered[index];
        return ListTile(
          leading: Icon(
            Icons.calendar_today,
            color: holiday.isMajor ? Colors.blue : Colors.grey,
          ),
          title: Text(
            holiday.hebrew,
            textAlign: TextAlign.right,
          ),
          subtitle: Text(
            '${holiday.title} · ${dateFormat.format(holiday.date)}',
          ),
        );
      },
    );
  }
}

class _DateRangeRow extends StatelessWidget {
  const _DateRangeRow({
    required this.dateFrom,
    required this.dateTo,
    required this.onTap,
    required this.fromLabel,
    required this.toLabel,
  });

  final DateTime dateFrom;
  final DateTime dateTo;
  final VoidCallback onTap;
  final String fromLabel;
  final String toLabel;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yyyy');
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.date_range, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              '$fromLabel: ${fmt.format(dateFrom)}',
              style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 12),
            Text(
              '$toLabel: ${fmt.format(dateTo)}',
              style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Icon(Icons.edit_calendar, size: 16, color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({
    required this.viewMode,
    required this.listLabel,
    required this.monthlyLabel,
    required this.onChanged,
  });

  final _ViewMode viewMode;
  final String listLabel;
  final String monthlyLabel;
  final ValueChanged<_ViewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SegmentedButton<_ViewMode>(
        segments: [
          ButtonSegment(
            value: _ViewMode.list,
            label: Text(listLabel),
            icon: const Icon(Icons.list),
          ),
          ButtonSegment(
            value: _ViewMode.monthly,
            label: Text(monthlyLabel),
            icon: const Icon(Icons.calendar_month),
          ),
        ],
        selected: {viewMode},
        onSelectionChanged: (s) => onChanged(s.first),
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
