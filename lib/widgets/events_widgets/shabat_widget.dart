import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ShabatWidget extends StatelessWidget {
  const ShabatWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isHebrewDate = Provider.of<Events>(context).isHebrewDate;
    final shabat = data is Shabat ? data as Shabat : null;

    return Column(
      children: [
        if (shabat != null && shabat.isMevarchim)
          ListTile(
            leading: const Icon(Icons.auto_awesome),
            title: Text(appLocalizations.mevarchimShabat),
            subtitle:
                shabat.mevarchimMonths != null &&
                        shabat.mevarchimMonths!.isNotEmpty
                    ? Text(
                        appLocalizations.blessingMonth(
                          shabat.mevarchimMonths!.join(', '),
                        ),
                      )
                    : null,
          ),
        if (data.entryDate != null)
          ListTile(
            title: Text(DateFormat('HH:mm').format(data.entryDate!)),
            subtitle: Text(appLocalizations.entryAndLightingCandles),
            trailing: DateWithTimeLeft(
              date: data.entryDate!,
              hebrewDate: isHebrewDate ? data.entryHebrewDate : null,
            ),
            leading: const Icon(Icons.fireplace_outlined),
          ),
        if (data.releaseDate != null)
          ListTile(
            title: Text(DateFormat('HH:mm').format(data.releaseDate!)),
            subtitle: Text(appLocalizations.departureAndHavdalah),
            trailing: DateWithTimeLeft(
              date: data.releaseDate!,
              hebrewDate: isHebrewDate ? data.releaseHebrewDate : null,
            ),
            leading: const Icon(Icons.wine_bar),
          ),
        ListTile(
          title: Text(
            Localizations.localeOf(context).languageCode == 'he' &&
                    data.titleOrig != null
                ? data.titleOrig!
                : data.parasha!,
          ),
          subtitle: Text(appLocalizations.parasha),
          leading: const Icon(Icons.book_outlined),
        ),
        if (shabat != null &&
            shabat.leyning != null &&
            shabat.leyning!.isNotEmpty)
          _LeyningSection(
            leyning: shabat.leyning!,
            appLocalizations: appLocalizations,
          ),
      ],
    );
  }
}

class _LeyningSection extends StatefulWidget {
  const _LeyningSection({
    required this.leyning,
    required this.appLocalizations,
  });

  final Map<String, String> leyning;
  final AppLocalizations appLocalizations;

  @override
  State<_LeyningSection> createState() => _LeynningSectionState();
}

class _LeynningSectionState extends State<_LeyningSection> {
  bool _expanded = false;
  final _headerKey = GlobalKey();

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (!_expanded) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_headerKey.currentContext != null) {
        Scrollable.ensureVisible(
          _headerKey.currentContext!,
          alignment: 0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  static const _hebrewBooks = {
    'Genesis': 'בראשית',
    'Exodus': 'שמות',
    'Leviticus': 'ויקרא',
    'Numbers': 'במדבר',
    'Deuteronomy': 'דברים',
    'Joshua': 'יהושע',
    'Judges': 'שופטים',
    'I Samuel': 'שמואל א',
    'II Samuel': 'שמואל ב',
    'I Kings': 'מלכים א',
    'II Kings': 'מלכים ב',
    'Isaiah': 'ישעיהו',
    'Jeremiah': 'ירמיהו',
    'Ezekiel': 'יחזקאל',
    'Hosea': 'הושע',
    'Joel': 'יואל',
    'Amos': 'עמוס',
    'Obadiah': 'עובדיה',
    'Jonah': 'יונה',
    'Micah': 'מיכה',
    'Nahum': 'נחום',
    'Habakkuk': 'חבקוק',
    'Zephaniah': 'צפניה',
    'Haggai': 'חגי',
    'Zechariah': 'זכריה',
    'Malachi': 'מלאכי',
  };

  static String _localizeRef(String ref, bool isHe) {
    String result = ref;
    if (isHe) {
      for (final entry in _hebrewBooks.entries) {
        if (result.startsWith(entry.key)) {
          result =
              entry.value + result.substring(entry.key.length);
          break;
        }
      }
    }
    // Simplify "ch:v1-ch:v2" → "ch:v1-v2" when same chapter
    result = result.replaceAllMapped(
      RegExp(r'(\d+):(\d+)-\1:(\d+)'),
      (m) => '${m[1]}:${m[2]}-${m[3]}',
    );
    return result;
  }

  static const _aliyaKeys = {
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    'M': 8,
  };

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isRtl =
        locale.languageCode == 'he' || locale.languageCode == 'ar';
    final aliyot = widget.leyning.entries
        .where((e) => _aliyaKeys.containsKey(e.key))
        .toList()
      ..sort(
        (a, b) =>
            _aliyaKeys[a.key]!.compareTo(_aliyaKeys[b.key]!),
      );
    final haftarah = widget.leyning['haftarah'];

    return Column(
      children: [
        InkWell(
          key: _headerKey,
          onTap: _toggle,
          child: ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: Text(widget.appLocalizations.torahReading),
            trailing: Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
            ),
          ),
        ),
        if (_expanded) ...[
          for (final entry in aliyot)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 2,
              ),
              child: Row(
                children: isRtl
                    ? [
                        Expanded(
                          child: Text(
                            _localizeRef(entry.value, isRtl),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 24,
                          child: Text(
                            entry.key,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]
                    : [
                        SizedBox(
                          width: 24,
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _localizeRef(entry.value, isRtl),
                          ),
                        ),
                      ],
              ),
            ),
          if (haftarah != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: isRtl
                    ? [
                        Expanded(
                          child: Text(
                            _localizeRef(haftarah, isRtl),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.appLocalizations.haftarah,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                    : [
                        Text(
                          widget.appLocalizations.haftarah,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _localizeRef(haftarah, isRtl),
                          ),
                        ),
                      ],
              ),
            ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
