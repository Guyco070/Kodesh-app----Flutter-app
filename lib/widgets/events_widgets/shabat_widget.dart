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

  static String _toHebNum(int n) {
    if (n <= 0) return n.toString();
    const ones = [
      '', 'א', 'ב', 'ג', 'ד', 'ה', 'ו', 'ז', 'ח', 'ט',
    ];
    const tens = [
      '', 'י', 'כ', 'ל', 'מ', 'נ', 'ס', 'ע', 'פ', 'צ',
    ];
    final letters = <String>[];
    int r = n;
    while (r >= 400) { letters.add('ת'); r -= 400; }
    if (r >= 300) { letters.add('ש'); r -= 300; }
    if (r >= 200) { letters.add('ר'); r -= 200; }
    if (r >= 100) { letters.add('ק'); r -= 100; }
    if (r == 15) {
      letters.addAll(['ט', 'ו']);
    } else if (r == 16) {
      letters.addAll(['ט', 'ז']);
    } else {
      if (r >= 10) { letters.add(tens[r ~/ 10]); r %= 10; }
      if (r > 0) { letters.add(ones[r]); }
    }
    if (letters.isEmpty) return '0';
    final s = letters.join();
    if (s.length == 1) return '$s׳';
    return '${s.substring(0, s.length - 1)}״${s[s.length - 1]}';
  }

  static String _localizeRef(String ref, bool isHe) {
    if (!isHe) return ref;

    String bookHe = '';
    String rest = ref;
    for (final entry in _hebrewBooks.entries) {
      if (ref.startsWith(entry.key)) {
        bookHe = entry.value;
        rest = ref.substring(entry.key.length).trim();
        break;
      }
    }

    final fullRange =
        RegExp(r'^(\d+):(\d+)-(\d+):(\d+)$').firstMatch(rest);
    final sameChRange =
        RegExp(r'^(\d+):(\d+)-(\d+)$').firstMatch(rest);
    final single =
        RegExp(r'^(\d+):(\d+)$').firstMatch(rest);

    String refHe;
    if (fullRange != null) {
      final ch1 = int.parse(fullRange.group(1)!);
      final v1 = int.parse(fullRange.group(2)!);
      final ch2 = int.parse(fullRange.group(3)!);
      final v2 = int.parse(fullRange.group(4)!);
      if (ch1 == ch2) {
        refHe =
            'פרק ${_toHebNum(ch1)}, '
            'פסוקים ${_toHebNum(v1)}-${_toHebNum(v2)}';
      } else {
        refHe =
            'פרק ${_toHebNum(ch1)} פסוק ${_toHebNum(v1)}'
            ' - פרק ${_toHebNum(ch2)} פסוק ${_toHebNum(v2)}';
      }
    } else if (sameChRange != null) {
      final ch = int.parse(sameChRange.group(1)!);
      final v1 = int.parse(sameChRange.group(2)!);
      final v2 = int.parse(sameChRange.group(3)!);
      refHe =
          'פרק ${_toHebNum(ch)}, '
          'פסוקים ${_toHebNum(v1)}-${_toHebNum(v2)}';
    } else if (single != null) {
      final ch = int.parse(single.group(1)!);
      final v = int.parse(single.group(2)!);
      refHe = 'פרק ${_toHebNum(ch)}, פסוק ${_toHebNum(v)}';
    } else {
      refHe = rest;
    }

    return bookHe.isEmpty ? refHe : '$bookHe $refHe';
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
              padding: isRtl
                  ? const EdgeInsets.only(
                      left: 56,
                      right: 16,
                      top: 2,
                      bottom: 2,
                    )
                  : const EdgeInsets.symmetric(
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
              padding: isRtl
                  ? const EdgeInsets.only(
                      left: 56,
                      right: 16,
                      top: 4,
                      bottom: 4,
                    )
                  : const EdgeInsets.symmetric(
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
