import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Nosah {
  mizrah,
  ashkenaz,
}

class AdlakatNerotChanukah extends StatefulWidget {
  const AdlakatNerotChanukah({super.key});
  static const String routeName = '/adlakat_nerot_chanuca';

  @override
  State<AdlakatNerotChanukah> createState() => _AdlakatNerotChanukahState();
}

class _AdlakatNerotChanukahState extends State<AdlakatNerotChanukah> {
  Nosah nosah = Nosah.mizrah;

  List<TextSpan> getSederWidgets() {
    final List<String> seder = bracha[nosah]!;
    TextStyle font;
    List<TextSpan> widgets = [];

    for (int i = 1; i < seder.length; i++) {
      String? text;
      if (seder[i][0] == 'B') {
        // T = title
        font = const TextStyle(fontWeight: FontWeight.w600, fontSize: 15);
        text = '${seder[i].substring(1, seder[i].length)}\n';
      } else if (seder[i][0] == 'T') {
        // T = title
        font = const TextStyle(fontWeight: FontWeight.w600, fontSize: 15);
        text = '\n${seder[i].substring(1, seder[i].length)}\n';
      } else if (seder[i][0] == 'S') {
        // T = title
        text = seder[i].substring(1, seder[i].length);
        font = const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.blueAccent);
      } else if (seder[i][seder[i].length - 1] == '.') {
        // T = title
        text = '${seder[i]}\n';
        font = const TextStyle(fontWeight: FontWeight.w300, fontSize: 14);
      } else {
        font = const TextStyle(fontWeight: FontWeight.w300, fontSize: 14);
      }

      widgets.add(TextSpan(
        text: text ?? seder[i],
        style: font,
      ));
    }

    return widgets;
  }

  Widget getNosahim() {
    List<Widget> widgets = [];
    for (Nosah i in Nosah.values) {
      widgets.add(
        Expanded(
          child: ElevatedButton(
            onPressed: i == nosah
                ? null
                : () {
                    setState(() {
                      nosah = i;
                    });
                  },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder()),
                backgroundColor: i == nosah
                    ? MaterialStatePropertyAll<Color>(
                        Theme.of(context).primaryColor)
                    : MaterialStatePropertyAll<Color>(Colors.blue.shade800)),
            child: Text(
              bracha[i]![0],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: nosah == i ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title:
                AppLocalizations.of(context)!.hanukkahCandleLightingOrderMenu),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    'assets/hanu.jpg',
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '* יש להניח את הנרות מימין לשמאל ולהדליקן משמאל לימין.\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.shade600),
                ),
              ),
              getNosahim(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    TextSpan(children: getSederWidgets())),
              )
              // ...getSederWidgets(),
            ]),
          ),
        ));
  }

  // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
  final Map<Nosah, List<String>> bracha = {
    Nosah.ashkenaz: const [
      'נוסח אשכנז',
      'Bלפני ההדלקה מברכים:',
      'Sבָּרוּךְ אַתָּה',
      ' יְיָ אֱלֹהֵינוּ מֶלֶךְ הָעוֹלָם',
      'אֲשֶׁר קִדְּשָׁנוּ בְּמִצְוֹתָיו וְצִוָּנוּ לְהַדְלִיק נֵר (שֶׁל) חֲנֻכָּה.',
      'Sבָּרוּךְ אַתָּה',
      ' יְיָ אֱלֹהֵינוּ מֶלֶךְ הָעוֹלָם',
      'שֶׁעָשָׂה נִסִּים לַאֲבוֹתֵינוּ בַּיָּמִים הָהֵם בַּזְּמַן הַזֶּה.',
      'Tבהדלקת הנר הראשון מוסיפים:',
      'Sבָּרוּךְ אַתָּה',
      ' יְיָ אֱלֹהֵינוּ מֶלֶךְ הָעוֹלָם ',
      'שֶׁהֶחֱיָנוּ וְקִיְּמָנוּ וְהִגִּיעָנוּ לַזְּמַן הַזֶּה.',
      'Tלאחר הדלקת הנרות שרים:',
      'Sהַנֵּרוֹת הַלָּלוּ',
      ' שֶׁאָנוּ מַדְלִיקִין, עַל הַנִּסִּים וְעַל הַנִּפְלָאוֹת וְעַל הַתְּשׁוּעוֹת וְעַל הַמִּלְחָמוֹת, שֶׁעָשִׂיתָ לַאֲבוֹתֵינוּ בַּיָּמִים הָהֵם בַּזְּמַן',
      'הַזֶּה, עַל יְדֵי כֹּהֲנֶיךָ הַקְּדוֹשִׁים. וְכָל שְׁמוֹנַת יְמֵי הַחֲנֻכָּה הַנֵּרוֹת הַלָּלוּ קֹדֶשׁ הֵם וְאֵין לָנוּ רְשׁוּת לְהִשְׁתַּמֵּשׁ בָּהֶם, אֶלָּא לִרְאוֹתָם בִּלְבָד, כְּדֵי לְהוֹדוֹת וּלְהַלֵּל לְשִׁמְךָ הַגָּדוֹל עַל נִסֶּיךָ וְעַל נִפְלְאוֹתֶיךָ וְעַל יְשׁוּעָתֶךָ.',
      'S\nמָעוֹז צוּר',
      ' יְשׁוּעָתִי לְךָ נָאֶה לְשַׁבֵּחַ.',
      'תִּכּוֹן בֵּית תְּפִלָּתִי וְשָׁם תּוֹדָה נְזַבֵּחַ.',
      'לְעֵת תָּכִין מַטְבֵּחַ מִצָּר הַמְנַבֵּחַ.',
      'אָז אֶגְמוֹר בְּשִׁיר מִזְמוֹר חֲנֻכַּת הַמִּזְבֵּחַ.',
      'רָעוֹת שָׂבְעָה נַפְשִׁי בְּיָגוֹן כֹּחִי כִּלָה.',
      'חַיַּי מָרְרוּ בְּקוֹשִׁי בְּשִׁעְבּוּד מַלְכוּת עֶגְלָה.',
      'וּבְיָדוֹ הַגְּדוֹלָה הוֹצִיא אֶת הַסְּגֻלָּה.',
      'חֵיל פַּרְעֹה וְכָל זַרְעוֹ יָרְדוּ כְאֶבֶן בִּמְצוּלָה.',
      'דְּבִיר קָדְשׁוֹ הֱבִיאַנִי וְגַם שָׁם לֹא שָׁקַטְתִּי.',
      'וּבָא נוֹגֵשׂ וְהִגְלַנִי. כִּי זָרִים עָבַדְתִּי.',
      'וְיֵין רַעַל מָסַכְתִּי כִּמְעַט שֶׁעָבַרְתִּי.',
      'קֵץ בָּבֶל, זְרֻבָּבֶל, לְקֵץ שִׁבְעִים נוֹשָׁעְתִּי.',
      'כְּרוֹת קוֹמַת בְּרוֹשׁ, בִּקֵּשׁ אֲגָגִי בֶּן הַמְּדָתָא. ',
      'וְנִהְיָתָה לוֹ לְפַח וּלְמוֹקֵשׁ וְגַאֲוָתוֹ נִשְׁבָּתָה.',
      'רֹאשׁ יְמִינִי נִשֵּׂאתָ וְאוֹיֵב שְׁמוֹ מָחִיתָ.',
      'רֹב בָּנָיו וְקִנְיָנָיו עַל הָעֵץ תָּלִיתָ.',
      'יְוָנִים נִקְבְּצוּ עָלַי אֲזַי בִּימֵי חַשְׁמַנִּים.',
      'וּפָרְצוּ חוֹמוֹת מִגְדָּלַי וְטִמְּאוּ כָּל הַשְּׁמָנִים.',
      'וּמִנּוֹתַר קַנְקַנִּים נַעֲשָׂה נֵס לַשּׁוֹשַׁנִּים.',
      'בְּנֵי בִינָה יְמֵי שְׁמוֹנָה קָבְעוּ שִׁיר וּרְנָנִים.',
      'חֲשׂוֹף זְרוֹעַ קָדְשֶׁךָ וְקָרֵב קֵץ הַיְשׁוּעָה.',
      'נְקֹם נִקְמַת דַּם עֲבָדֶיךָ מֵאֻמָּה הָרְשָׁעָה.',
      'כִּי אָרְכָה לָנוּ הַשָּׁעָה וְאֵין קֵץ לִימֵי הָרָעָה.',
      'דְּחֵה אַדְמוֹן בְּצֵל צַלְמוֹן, הָקֵם לָנוּ רוֹעֶה שִׁבְעָה.',
    ],
    Nosah.mizrah: const [
      'נוסח מזרח',
      'Bלפני ההדלקה מברכים:',
      'Sבָּרוּךְ אַתָּה',
      ' יְיָ אֱלֹהֵינוּ מֶלֶךְ הָעוֹלָם',
      'אֲשֶׁר קִדְּשָׁנוּ בְּמִצְוֹתָיו וְצִוָּנוּ לְהַדְלִיק נֵר (שֶׁל) חֲנֻכָּה.',
      'Sבָּרוּךְ אַתָּה',
      ' יְיָ אֱלֹהֵינוּ מֶלֶךְ הָעוֹלָם',
      'שֶׁעָשָׂה נִסִּים לַאֲבוֹתֵינוּ בַּיָּמִים הָהֵם בַּזְּמַן הַזֶּה.',
      'Tבהדלקת הנר הראשון מוסיפים:',
      'Sבָּרוּךְ אַתָּה',
      ' יְיָ אֱלֹהֵינוּ מֶלֶךְ הָעוֹלָם ',
      'שֶׁהֶחֱיָנוּ וְקִיְּמָנוּ וְהִגִּיעָנוּ לַזְּמַן הַזֶּה.',
      'Tלאחר הדלקת הנרות שרים:',
      'Sהַנֵּרוֹת הַלָּלוּ',
      'אֲנַחְנוּ מַדְלִיקִין, עַל הַנִּסִּים וְעַל הַתְּשׁוּעוֹת וְעַל הַנִּפְלָאוֹת, שֶׁעָשִׂיתָ לַאֲבוֹתֵינוּ עַל יְדֵי כֹּהֲנֶיךָ הַקְּדוֹשִׁים. וְכָל שְׁמוֹנַת יְמֵי חֲנֻכָּה הַנֵּרוֹת הַלָּלוּ קֹדֶשׁ, וְאֵין לָנוּ רְשׁוּת לְהִשְׁתַּמֵּשׁ בָּהֶם, אֶלָּא לִרְאוֹתָם בִּלְבָד, כְּדֵי לְהוֹדוֹת לִשְׁמֶךָ עַל נִסֶּיךָ נִפְלְאוֹתֶיךָ וּתְשׁוּעוֹתֶיךָ.',
      'S\nמִזְמוֹר שִׁיר',
      ' חֲנֻכַּת הַבַּיִת לְדָוִד: אֲרוֹמִמְךָ יְיָ כִּי דִלִּיתָנִי וְלֹא שִׂמַּחְתָּ אֹיְבַי לִי: יְיָ ',
      'אֱלֹהָי שִׁוַּעְתִּי אֵלֶיךָ וַתִּרְפָּאֵנִי: יְיָ הֶעֱלִיתָ מִן שְׁאוֹל נַפְשִׁי חִיִּיתַנִי מִיָּרְדִי בוֹר: זַמְּרוּ ',
      'לַיְיָ חֲסִידָיו וְהוֹדוּ לְזֵכֶר קָדְשׁוֹ: כִּי רֶגַע בְּאַפּוֹ חַיִּים בִּרְצוֹנוֹ בָּעֶרֶב יָלִין בֶּכִי וְלַבֹּקֶר רִנָּה: וַאֲנִי אָמַרְתִּי בְשַׁלְוִי בַּל אֶמּוֹט ',
      'לְעוֹלָם: יְיָ בִּרְצוֹנְךָ הֶעֱמַדְתָּה לְהַרְרִי עֹז הִסְתַּרְתָּ פָנֶיךָ הָיִיתִי ',
      'נִבְהָל: אֵלֶיךָ יְיָ אֶקְרָא וְאֶל אֲדֹנָי אֶתְחַנָּן: מַה בֶּצַע בְּדָמִי ',
      'בְּרִדְתִּי אֶל שָׁחַת הֲיוֹדְךָ עָפָר הֲיַגִּיד אֲמִתֶּךָ: שְׁמַע יְיָ וְחָנֵּנִי יְיָ ',
      'הֶיֵה עֹזֵר לִי: הָפַכְתָּ מִסְפְּדִי לְמָחוֹל לִי פִּתַּחְתָּ שַׂקִּי',
      'וַתְּאַזְּרֵנִי שִׂמְחָה: לְמַעַן יְזַמֶּרְךָ כָבוֹד ',
      'וְלֹא יִדֹּם יְיָ אֱלֹהַי לְעוֹלָם אוֹדֶךָּ.',
      'S\nמָעוֹז צוּר',
      ' יְשׁוּעָתִי לְךָ נָאֶה לְשַׁבֵּחַ.',
      'תִּכּוֹן בֵּית תְּפִלָּתִי וְשָׁם תּוֹדָה נְזַבֵּחַ.',
      'לְעֵת תָּכִין מַטְבֵּחַ מִצָּר הַמְנַבֵּחַ.',
      'אָז אֶגְמוֹר בְּשִׁיר מִזְמוֹר חֲנֻכַּת הַמִּזְבֵּחַ.',
      'רָעוֹת שָׂבְעָה נַפְשִׁי בְּיָגוֹן כֹּחִי כִּלָה.',
      'חַיַּי מָרְרוּ בְּקוֹשִׁי בְּשִׁעְבּוּד מַלְכוּת עֶגְלָה.',
      'וּבְיָדוֹ הַגְּדוֹלָה הוֹצִיא אֶת הַסְּגֻלָּה.',
      'חֵיל פַּרְעֹה וְכָל זַרְעוֹ יָרְדוּ כְאֶבֶן בִּמְצוּלָה.',
      'דְּבִיר קָדְשׁוֹ הֱבִיאַנִי וְגַם שָׁם לֹא שָׁקַטְתִּי.',
      'וּבָא נוֹגֵשׂ וְהִגְלַנִי. כִּי זָרִים עָבַדְתִּי.',
      'וְיֵין רַעַל מָסַכְתִּי כִּמְעַט שֶׁעָבַרְתִּי.',
      'קֵץ בָּבֶל, זְרֻבָּבֶל, לְקֵץ שִׁבְעִים נוֹשָׁעְתִּי.',
      'כְּרוֹת קוֹמַת בְּרוֹשׁ, בִּקֵּשׁ אֲגָגִי בֶּן הַמְּדָתָא. ',
      'וְנִהְיָתָה לוֹ לְפַח וּלְמוֹקֵשׁ וְגַאֲוָתוֹ נִשְׁבָּתָה.',
      'רֹאשׁ יְמִינִי נִשֵּׂאתָ וְאוֹיֵב שְׁמוֹ מָחִיתָ.',
      'רֹב בָּנָיו וְקִנְיָנָיו עַל הָעֵץ תָּלִיתָ.',
      'יְוָנִים נִקְבְּצוּ עָלַי אֲזַי בִּימֵי חַשְׁמַנִּים.',
      'וּפָרְצוּ חוֹמוֹת מִגְדָּלַי וְטִמְּאוּ כָּל הַשְּׁמָנִים.',
      'וּמִנּוֹתַר קַנְקַנִּים נַעֲשָׂה נֵס לַשּׁוֹשַׁנִּים.',
      'בְּנֵי בִינָה יְמֵי שְׁמוֹנָה קָבְעוּ שִׁיר וּרְנָנִים.',
      'חֲשׂוֹף זְרוֹעַ קָדְשֶׁךָ וְקָרֵב קֵץ הַיְשׁוּעָה.',
      'נְקֹם נִקְמַת דַּם עֲבָדֶיךָ מֵאֻמָּה הָרְשָׁעָה.',
      'כִּי אָרְכָה לָנוּ הַשָּׁעָה וְאֵין קֵץ לִימֵי הָרָעָה.',
      'דְּחֵה אַדְמוֹן בְּצֵל צַלְמוֹן, הָקֵם לָנוּ רוֹעֶה שִׁבְעָה.'
    ],
  };
}
