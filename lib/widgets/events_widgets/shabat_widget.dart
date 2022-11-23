import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';

class ShabatWidget extends StatelessWidget {
  const ShabatWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (data.entryDate != null)
          ListTile(
            title: Text(
              DateFormat('HH:mm').format(data.entryDate!),
              textAlign: TextAlign.right,
            ),
            subtitle: const Text(
              'כניסה והדלקת נרות',
              textAlign: TextAlign.right,
            ),
            leading: DateWithTimeLeft(date: data.entryDate!),
            trailing: const Icon(Icons.fireplace_outlined),
          ),
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
            leading: DateWithTimeLeft(date: data.releaseDate!),
            trailing: const Icon(Icons.wine_bar),
          ),
        ListTile(
          title: Text(
            data.parasha!,
            textAlign: TextAlign.right,
          ),
          subtitle: const Text(
            'פרשת שבוע',
            textAlign: TextAlign.right,
          ),
          trailing: const Icon(Icons.book_outlined),
        ),
      ],
    );
  }
}
