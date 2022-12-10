import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventFactoryWidget extends StatelessWidget {
  const EventFactoryWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
          indent: 35,
          endIndent: 35,
          height: 40,
        ),
        Text(data.title == 'Shabat' ? AppLocalizations.of(context)!.shabat : data.title),
        Events.eventsFactoryMethod(data)!,
      ],
    );
  }
}
