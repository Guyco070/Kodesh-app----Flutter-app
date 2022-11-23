import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';

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
        Text(data.title),
        Events.eventsFactoryMethod(data)!,
      ],
    );
  }
}
