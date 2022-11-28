import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';

class RoshChodeshWidget extends StatelessWidget {
  const RoshChodeshWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (data.releaseDate == null && data.entryDate != null) dateFix('oe')
        else if (data.entryDate != null) dateFix('e'),
        if (data.releaseDate != null) dateFix('r'),
      ],
    );
  }

  ListTile dateFix(String type) {
    DateTime date = type == 'oe' || type == 'e' ? data.entryDate! : data.releaseDate!;
    String subtitle = type == 'oe' ? 'תאריך סיום האירוע' : type == 'e' ? 'תאריך התחלה' : 'תאריך סיום';
    IconData icon = type == 'oe' ? Icons.calendar_month_outlined : type == 'e' ? Icons.first_page : Icons.last_page;
      return ListTile(
        title: Text(
          DateFormat('dd/MM/yyyy').format(date),
          textAlign: TextAlign.right,
        ),
      leading: TimeLeft(date: data.entryDate!),
        subtitle: Text(
          subtitle,
          textAlign: TextAlign.right,
        ),
        trailing: Icon(icon),
      );
  }
}
