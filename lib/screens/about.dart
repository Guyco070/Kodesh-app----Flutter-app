import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

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
            children: Provider.of<Tfilot>(
              context,
              listen: false,
            ).getSederWidgets(textList: aboutText),
          ),
        ),
      ),
    );
  }

  final Map<String, List<String>> aboutText = const {
    // Each body starts with a leading space so getSederWidgets never mistakes
    // the first letter for a formatting code ('B'/'T'/'S').
    'he': [
      '',
      ' האפליקציה פותחה על מנת לעזור למשתמשיה אשר רוצים לדעת את זמני כניסת ויציאת שבתות וחגים, זמני היום וכדומה, באמצעות כניסה אליה או באמצעות קבלת תזכורות כפי שייקבעו בעמוד \'קביעת תזכורות\'. '
          'כמו כן ניתן לקבוע תזכורות נוספות, למשל תזכורות להנחת תפילין. '
          'אך יש לשים לב כי לשם קבלת תזכורות אלו על המשתמש להיכנס לאפליקציה לפחות פעם בשבוע. '
          'יוצרי האפליקציה אינם לוקחים כל אחריות על תזמוני התזכורות, ועל המשתמש לקחת בחשבון כי ייתכנו תקלות בתזמון התזכורות ואין להסתמך עליהן בלבד. '
          'בנוסף, ייתכן שתופענה תזכורות שגויות.',
    ],
    'en': [
      '',
      ' This app was developed to help its users who want to know the entry and exit times of Shabbat and holidays, the daily zmanim and the like — either by opening the app or by receiving reminders as configured on the \'Setting reminders\' page. '
          'You can also set additional reminders, for example reminders to put on tefillin. '
          'Note that, in order to receive these reminders, the user must open the app at least once a week. '
          'The app\'s creators take no responsibility for the timing of the reminders, and the user should keep in mind that reminder timing may fail and the reminders should not be relied upon on their own. '
          'In addition, incorrect reminders may occasionally appear.',
    ],
    'es': [
      '',
      ' Esta aplicación fue desarrollada para ayudar a los usuarios que desean conocer los horarios de entrada y salida de Shabat y las festividades, los horarios del día (zmanim) y similares, ya sea abriéndola o mediante recordatorios configurados en la página \'Configurar recordatorios\'. '
          'También se pueden establecer recordatorios adicionales, por ejemplo para colocarse los tefilín. '
          'Tenga en cuenta que, para recibir estos recordatorios, el usuario debe abrir la aplicación al menos una vez por semana. '
          'Los creadores de la aplicación no asumen ninguna responsabilidad por los horarios de los recordatorios, y el usuario debe tener en cuenta que pueden producirse fallos en su programación y que no debe depender únicamente de ellos. '
          'Además, es posible que aparezcan recordatorios incorrectos.',
    ],
    'ru': [
      '',
      ' Это приложение было разработано, чтобы помочь пользователям, которые хотят знать время наступления и исхода суббот и праздников, зманим (время суток) и тому подобное — открывая приложение или получая напоминания, настроенные на странице «Настройка напоминаний». '
          'Также можно задать дополнительные напоминания, например напоминания о наложении тфилин. '
          'Обратите внимание, что для получения этих напоминаний пользователь должен открывать приложение не реже одного раза в неделю. '
          'Создатели приложения не несут ответственности за время напоминаний, и пользователю следует учитывать, что в их работе возможны сбои и не стоит полагаться только на них. '
          'Кроме того, иногда могут появляться ошибочные напоминания.',
    ],
  };
}
