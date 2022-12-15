import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventFactoryWidget extends StatelessWidget {
  const EventFactoryWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(data is! Shabat)...{
          const Divider(
          thickness: 2,
          indent: 10,
          endIndent: 10,
          height: 40,
        ),
        }else...{
        const Divider(
          thickness: 2,
          indent: 10,
          endIndent: 10,
          height: 5,
        ),
        const SizedBox(height: 15,)
        },
        Text(data.title == 'Shabat' ? AppLocalizations.of(context)!.shabat : data.title, style: TextStyle(fontWeight: FontWeight.w600,),),
        const Divider(
          thickness: 0.5,
          indent: 35,
          endIndent: 35,
          height: 40,
        ),
        Events.eventsFactoryMethod(data)!,
      ],
    );
  }
}
