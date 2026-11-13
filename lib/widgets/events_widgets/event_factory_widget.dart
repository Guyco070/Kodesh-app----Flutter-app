import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/molad.dart';
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

  static String _resolveTitle(BuildContext context, Event data) {
    if (data.title == 'Shabat') {
      return AppLocalizations.of(context)!.shabat;
    }
    final isHe = Localizations.localeOf(context).languageCode == 'he';
    if (isHe && data.titleOrig != null && data is! Shabat) {
      return data.titleOrig!;
    }
    return data.title;
  }

  /// Events whose body already carries the full text are shown without a
  /// heading, so the same sentence isn't rendered twice.
  static bool _hasHeading(Event data) => data is! Molad;

  @override
  String toStringShort() {
    return '${super.toStringShort()} - ${data.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    final hasHeading = _hasHeading(data);
    return Column(
      children: [
        if (!isFirst) ...{
          Divider(
            thickness: hasHeading ? 2 : 0.5,
            indent: hasHeading ? 10 : 35,
            endIndent: hasHeading ? 10 : 35,
            height: hasHeading ? 40 : 24,
          ),
        } else ...{
          const SizedBox(height: 15),
        },
        if (hasHeading) ...[
          Text(
            _resolveTitle(context, data),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Divider(thickness: 0.5, indent: 35, endIndent: 35, height: 40),
        ],
        Events.eventsFactoryMethod(data)!,
      ],
    );
  }
}
