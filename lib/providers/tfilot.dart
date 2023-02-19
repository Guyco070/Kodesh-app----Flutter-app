import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Nosah {
  mizrah,
  ashkenaz,
  sfarad,
}

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
    prefs.setString(_nosah.name, 'nosah');
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
    List<Widget> widgets = [];

    Map<Nosah, List<String>> bracha =
        getBracha[LanguageChangeProvider.getCurrentLocale.languageCode]!;

    for (Nosah i in bracha.keys) {
      widgets.add(
        Expanded(
          child: ElevatedButton(
            onPressed: i == _nosah
                ? null
                : () {
                    updateNosah(i);
                  },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder()),
                backgroundColor: i == _nosah
                    ? MaterialStatePropertyAll<Color>(
                        Theme.of(context).primaryColor)
                    : MaterialStatePropertyAll<Color>(Colors.blue.shade800)),
            child: Text(
              nosahTranslate(context)[i],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      _nosah == i ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: widgets)),
    );
  }

  List<TextSpan> getSederWidgets(
      {Map getBracha = const {},
      bool isWithNosah = false,
      Map<String, List<String>>? textList,
      double fontSizeScale = 0}) {
    final List<String> seder = textList != null
        ? textList[LanguageChangeProvider.getCurrentLocale.languageCode]!
        : (getBracha[LanguageChangeProvider.getCurrentLocale.languageCode])![
            isWithNosah ? _nosah : Nosah.mizrah] as List<String>;
    TextStyle font;
    List<TextSpan> widgets = [];
    final double titleFontSize = 15 + fontSizeScale;
    final double bodyFontSize = 14 + fontSizeScale;

    for (int i = 1; i < seder.length; i++) {
      String? text;
      if (seder[i][0] == 'B') {
        // B = First line of the prey
        font = TextStyle(fontWeight: FontWeight.w600, fontSize: titleFontSize);
        text = '${seder[i].substring(1, seder[i].length)}\n';
      } else if (seder[i][0] == 'T') {
        // T = title
        font = TextStyle(fontWeight: FontWeight.w600, fontSize: titleFontSize);
        text = '\n${seder[i].substring(1, seder[i].length)}\n';
      } else if (seder[i][0] == 'S') {
        // S = Start of a sentens
        text = seder[i].substring(1, seder[i].length);
        if (seder[i][seder[i].length - 1] == '.' ||
            seder[i][seder[i].length - 1] == ':') text += '\n\n';
        font = TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: titleFontSize,
            color: Colors.blueAccent);
      } else if (seder[i][seder[i].length - 1] == '.') {
        // end of line
        text = '${seder[i]}\n';
        font = TextStyle(fontWeight: FontWeight.w300, fontSize: bodyFontSize);
      } else if (seder[i][seder[i].length - 1] == ':') {
        // end of line
        text = '${seder[i]}\n\n';
        font = TextStyle(fontWeight: FontWeight.w300, fontSize: bodyFontSize);
      } else {
        font = TextStyle(fontWeight: FontWeight.w300, fontSize: bodyFontSize);
      }

      widgets.add(TextSpan(
        text: text ?? seder[i],
        style: font,
      ));
    }

    return widgets;
  }
}
