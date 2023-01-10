import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  static String routeName = '/about';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.aboutMenu),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              TextSpan(
                  children: Provider.of<Tfilot>(context, listen: false)
                      .getSederWidgets(textList: aboutText))),
        ));
  }

  final Map<String, List<String>> aboutText = const {
    'he':  [
      '',
      'האפליקצייה פותחה על מנת לעזור למשתמשיה אשר רוצים לדעת את זמני כניסת ויציאת שבתות וחגים, זמני היום וכדומה באמצעות כניסה אליה או באמצעות קבלת תזכורות כפי שייקבעו בעמוד \'קביעת תזכורות\'.'
      'כמו כן ניתן לקבוע תזכורות תזכורות נוספות למשל תזכורות להנחת תפילין.'
      'אך יש לשים לב כי לשם קבלת תזכורות אלו על המשתמש להכנס לאפליקצייה לפחות פעם בשבוע.'
      'יוצרי האפליקציה אינם לוקחים כל אחריות על תזמוני הצזכורות ועל המשתמש לקחת בחשבון כי ייתכנו תקלות בתזמון התזכורות ואין להסתמך על התזכורות.'
      'בנוסף, תזכורות שגויות עלולות .'
    ],
    'en': [
      '',
      'האפליקצייה פותחה על מנת לעזור למשתמשיה אשר רוצים לדעת את זמני כניסת ויציאת שבתות וחגים, זמני היום וכדומה באמצעות כניסה אליה או באמצעות קבלת תזכורות כפי שייקבעו בעמוד \'קביעת תזכורות\'.'
      'כמו כן ניתן לקבוע תזכורות תזכורות נוספות למשל תזכורות להנחת תפילין.'
      'אך יש לשים לב כי לשם קבלת תזכורות אלו על המשתמש להכנס לאפליקצייה לפחות פעם בשבוע.'
      'יוצרי האפליקציה אינם לוקחים כל אחריות על תזמוני הצזכורות ועל המשתמש לקחת בחשבון כי ייתכנו תקלות בתזמון התזכורות ואין להסתמך על התזכורות.'
      'בנוסף, תזכורות שגויות עלולות .'
    ],
  };
}
