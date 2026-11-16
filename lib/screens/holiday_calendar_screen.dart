import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:kodesh_app/widgets/glass_segmented_choice.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
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
    _dateTo = DateTime(
      DateTime.now().year + 1,
      DateTime.now().month,
      DateTime.now().day,
    );
    _loadHolidays();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHolidays() async {
    setState(() => _isLoading = true);
    await Provider.of<Events>(
      context,
      listen: false,
    ).fetchAnnualHolidays(startDate: _dateFrom, endDate: _dateTo);
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

    return GlassScaffold(
      backdrop: KodeshBackdrop.sunset,
      appBar: CustomAppBar(title: appLocalizations.holidayCalendarMenu),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: TabHeader.maxContentWidth,
          ),
          child: Column(
            children: [
              // The monthly view pages month by month, so the date range only
              // applies to the list view.
              if (_viewMode == _ViewMode.list)
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
              Expanded(child: _buildBody(appLocalizations, events)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(AppLocalizations appLocalizations, Events events) {
    // The monthly view loads its own data one month at a time.
    if (_viewMode == _ViewMode.monthly) {
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16,
          4,
          16,
          24 + MediaQuery.of(context).viewPadding.bottom,
        ),
        child: GlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: MonthlyCalendarView(
            initialMonth: DateTime.now(),
            searchText: _searchText,
          ),
        ),
      );
    }

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
    final filtered =
        allHolidays.where((h) {
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

    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat.yMMMMEEEEd(locale.toLanguageTag());
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        16,
        4,
        16,
        24 + MediaQuery.of(context).viewPadding.bottom,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final holiday = filtered[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: Icon(
              Icons.calendar_today,
              color:
                  holiday.isMajor
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
            ),
            title: Text(
              holiday.displayName(locale.languageCode),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(dateFormat.format(holiday.date)),
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
    final fmt = DateFormat.yMd(Localizations.localeOf(context).toLanguageTag());
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        // Lines up with the icons inside the cards below.
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.date_range, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              '$fromLabel: ${fmt.format(dateFrom)}',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$toLabel: ${fmt.format(dateTo)}',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GlassSegmentedChoice<_ViewMode>(
        options: {_ViewMode.list: listLabel, _ViewMode.monthly: monthlyLabel},
        selected: viewMode,
        onSelected: onChanged,
      ),
    );
  }
}
