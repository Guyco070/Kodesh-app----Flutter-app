import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/molad.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';

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
    return Padding(
      padding: EdgeInsets.fromLTRB(16, isFirst ? 4 : 6, 16, 6),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: GlassPanel(
          padding: EdgeInsets.fromLTRB(4, hasHeading ? 16 : 6, 4, 6),
          child: Column(
            children: [
              if (hasHeading) ...[
                Semantics(
                  header: true,
                  child: Text(
                    _resolveTitle(context, data),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Divider(indent: 20, endIndent: 20, height: 24),
              ],
              Events.eventsFactoryMethod(data)!,
            ],
          ),
        ),
      ),
    );
  }
}
