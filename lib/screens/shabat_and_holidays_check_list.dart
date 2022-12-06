import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/appBar.dart';
import 'package:kodesh_app/widgets/thing_to_remind.dart';
import 'package:provider/provider.dart';

class ShabatAndHolidaysCheckList extends StatelessWidget {
  const ShabatAndHolidaysCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    Reminders reminders = Provider.of<Reminders>(context);
    return Scaffold(
      appBar: getRightBackAppBar(context, 'מטלות לפני שבת'),
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        padding: const EdgeInsets.all(25),
        childAspectRatio: 0.8,
        children: reminders.shabatAndHolidaysThingsToRemindList.map((e) {
          Map<String, Object> rElement =
              reminders.allShabatAndHolidaysThingsToRemindMap[e]!;

          return ThingToRemind(
              title: rElement['text'] as String,
              icon: rElement['icon'] as IconData,);
        }).toList(),
      ),
    );
  }

  static const routeName = '/shabat_and_holidays_check_list';
}
