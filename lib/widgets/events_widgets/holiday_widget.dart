import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';

class HolidayWidget extends StatelessWidget {
  const HolidayWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (data.entryDate != null) entryDateFix,
        if (data.releaseDate != null)
          ListTile(
            title: Text(
              DateFormat('HH:mm').format(data.releaseDate!),
              textAlign: TextAlign.right,
            ),
            subtitle: const Text(
              'יציאה והבדלה',
              textAlign: TextAlign.right,
            ),
            leading: Text(DateFormat('dd/MM/yyyy').format(data.releaseDate!)),
            trailing: const Icon(Icons.wine_bar),
          ),
      ],
    );
  }

  ListTile get entryDateFix {
    String time = DateFormat('HH:mm').format(data.entryDate!);
    if (time == '00:00') {
      return ListTile(
        title: Text(DateFormat('dd/MM/yyyy').format(data.entryDate!),
        textAlign: TextAlign.right,
      ),
      leading: TimeLeft(date: data.entryDate!),
      subtitle: const Text(
        'תאריך האירוע',
        textAlign: TextAlign.right,
      ),
      trailing: const Icon(Icons.event),
    );
    }
    return ListTile(
      title: Text(
        time,
        textAlign: TextAlign.right,
      ),
      subtitle: const Text(
        'כניסה והדלקת נרות',
        textAlign: TextAlign.right,
      ),
      leading: TimeLeft(date: data.entryDate!),
      trailing: const Icon(Icons.fireplace_outlined),
    );
  }
}
