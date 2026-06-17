import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

class EventFactoryWidget extends StatelessWidget {
  const EventFactoryWidget({
    super.key,
    required this.data,
    this.isFirst = false,
  });
  final Event data;
  final bool isFirst;

  @override
  String toStringShort() {
    return '${super.toStringShort()} - ${data.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst) ...{
          const Divider(thickness: 2, indent: 10, endIndent: 10, height: 40),
        } else ...{
          const SizedBox(height: 15),
        },
        Text(
          data.title == 'Shabat'
              ? AppLocalizations.of(context)!.shabat
              : data.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Divider(thickness: 0.5, indent: 35, endIndent: 35, height: 40),
        Events.eventsFactoryMethod(data)!,
      ],
    );
  }
}
