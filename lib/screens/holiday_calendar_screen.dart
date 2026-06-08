import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class HolidayCalendarScreen extends StatefulWidget {
  const HolidayCalendarScreen({super.key});

  static const String routeName = '/holiday_calendar';

  @override
  State<HolidayCalendarScreen> createState() => _HolidayCalendarScreenState();
}

class _HolidayCalendarScreenState extends State<HolidayCalendarScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadHolidays();
  }

  Future<void> _loadHolidays() async {
    setState(() => _isLoading = true);
    await Provider.of<Events>(context, listen: false).fetchAnnualHolidays();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final events = Provider.of<Events>(context);

    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.holidayCalendarMenu),
      body: _buildBody(appLocalizations, events),
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

    final holidays = events.annualHolidays;
    if (holidays == null || holidays.isEmpty) {
      return Center(child: Text(appLocalizations.noHolidaysFound));
    }

    final dateFormat = DateFormat('d MMMM yyyy');

    return ListView.builder(
      itemCount: holidays.length,
      itemBuilder: (context, index) {
        final holiday = holidays[index];
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
