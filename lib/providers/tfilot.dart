import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass_segmented_choice.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

enum Nosah { mizrah, ashkenaz, sfarad }

nosahTranslate(BuildContext context) {
  AppLocalizations appLocalizations = AppLocalizations.of(context)!;
  return {
    Nosah.mizrah: appLocalizations.mizrahVirsion,
    Nosah.ashkenaz: appLocalizations.ashkenazVirsion,
    Nosah.sfarad: appLocalizations.sfaradVirsion,
  };
}

class Tfilot with ChangeNotifier {
  Nosah _nosah = Nosah.mizrah;

  Tfilot() {
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> prefsKeys = prefs.getKeys();

    if (prefsKeys.contains('nosah')) {
      _nosah = getNosahFromString(prefs.getString('nosah')!);
    }
    notifyListeners();
  }

  Nosah get getNosah => _nosah;

  updateNosah(Nosah newNosah) async {
    _nosah = newNosah;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nosah', _nosah.name);
  }

  Nosah getNosahFromString(String? nosahName) {
    if (nosahName != null) {
      for (Nosah i in Nosah.values) {
        if (nosahName == i.name) return i;
      }
    }
    return _nosah;
  }

  Widget getNosahim(BuildContext context, Map getBracha) {
    final langCode = LanguageChangeProvider.getCurrentLocale.languageCode;
    Map<Nosah, List<String>> bracha =
        (getBracha[langCode] ?? getBracha['en'] ?? getBracha.values.first)
            as Map<Nosah, List<String>>;
    final labels = nosahTranslate(context);

    // No outer padding: it spans the same width as the text panel below.
    return GlassSegmentedChoice<Nosah>(
      semanticLabel: AppLocalizations.of(context)!.prayerVersion,
      options: {for (final n in bracha.keys) n: labels[n] as String},
      selected: bracha.containsKey(_nosah) ? _nosah : bracha.keys.first,
      onSelected: updateNosah,
    );
  }

  List<TextSpan> getSederWidgets({
    Map getBracha = const {},
    bool isWithNosah = false,
    Map<String, List<String>>? textList,
    double fontSizeScale = 0,
  }) {
    final langCode = LanguageChangeProvider.getCurrentLocale.languageCode;
    final List<String> seder =
        textList != null
            ? (textList[langCode] ?? textList['en'] ?? textList.values.first)
            : ((getBracha[langCode] ??
                    getBracha['en'] ??
                    getBracha.values.first)
                as Map<Nosah, List<String>>)[isWithNosah
                ? _nosah
                : Nosah.mizrah]!;
    TextStyle font;
    List<TextSpan> widgets = [];
    // Sized for the serif prayer font; each text-size step is 2 px.
    final double titleFontSize = 22 + 2 * fontSizeScale;
    final double bodyFontSize = 20 + 2 * fontSizeScale;

    for (int i = 1; i < seder.length; i++) {
      String? text;
      if (seder[i][0] == 'B') {
        // B = First line of the prey
        font = TextStyle(fontWeight: FontWeight.w700, fontSize: titleFontSize);
        text = '${seder[i].substring(1, seder[i].length)}\n';
      } else if (seder[i][0] == 'T') {
        // T = title
        font = TextStyle(fontWeight: FontWeight.w700, fontSize: titleFontSize);
        text = '\n${seder[i].substring(1, seder[i].length)}\n';
      } else if (seder[i][0] == 'S') {
        // S = Start of a sentens
        text = seder[i].substring(1, seder[i].length);
        if (seder[i][seder[i].length - 1] == '.' ||
            seder[i][seder[i].length - 1] == ':')
          text += '\n\n';
        font = TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: titleFontSize,
          color: KodeshPalette.sentenceBlue,
        );
      } else if (seder[i][seder[i].length - 1] == '.') {
        // end of line
        text = '${seder[i]}\n';
        font = TextStyle(fontWeight: FontWeight.w400, fontSize: bodyFontSize);
      } else if (seder[i][seder[i].length - 1] == ':') {
        // end of line
        text = '${seder[i]}\n\n';
        font = TextStyle(fontWeight: FontWeight.w400, fontSize: bodyFontSize);
      } else {
        font = TextStyle(fontWeight: FontWeight.w400, fontSize: bodyFontSize);
      }

      widgets.add(TextSpan(text: text ?? seder[i], style: font));
    }

    // Line breaks after the last line would only add empty space at the
    // bottom of the text panel.
    if (widgets.isNotEmpty) {
      final last = widgets.removeLast();
      widgets.add(
        TextSpan(
          text: last.text?.replaceFirst(RegExp(r'\s+$'), ''),
          style: last.style,
        ),
      );
    }
    return widgets;
  }
}
