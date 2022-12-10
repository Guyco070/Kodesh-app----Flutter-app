import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/thing_to_remind.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShabatAndHolidaysCheckList extends StatefulWidget {
  const ShabatAndHolidaysCheckList({super.key});

  @override
  State<ShabatAndHolidaysCheckList> createState() => _ShabatAndHolidaysCheckListState();

  static const routeName = '/shabat_and_holidays_check_list';
}

class _ShabatAndHolidaysCheckListState extends State<ShabatAndHolidaysCheckList> {
    bool _isAll = false;

  @override
  Widget build(BuildContext context) {
    Reminders reminders = Provider.of<Reminders>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations.choresBeforeShabbatMenu,
        trailing: TextButton(
          onPressed: () {
            setState(() {
              _isAll = !_isAll;
            });
          },
          child: Text(
            _isAll ? appLocalizations.all : appLocalizations.my,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
      body: _isAll || reminders.shabatAndHolidaysThingsToRemindList.isNotEmpty ? GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        padding: const EdgeInsets.all(25),
        childAspectRatio: 0.8,
        children: (_isAll ? reminders.allShabatAndHolidaysThingsToRemindMap(context).keys : reminders.shabatAndHolidaysThingsToRemindList).map((e) {
          Map<String, Object> rElement =
              reminders.allShabatAndHolidaysThingsToRemindMap(context)[e]!;
          return ThingToRemind(
            title: rElement['action'] as String,
            icon: rElement['icon'] as IconData,
          );
        }).toList(),
      ) : 
      Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(appLocalizations.noChroesMessage, textAlign: TextAlign.center,),
      )),
    );
  }
}
