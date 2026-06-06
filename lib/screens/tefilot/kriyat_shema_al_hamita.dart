import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/tefila_widget.dart';

class KriyatShemaAlHamita extends StatelessWidget {
  KriyatShemaAlHamita({super.key});
  static String routeName = '/kriyat_shema_al_hamita';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.kriyatShemaAlHamitaMenu,
      ),
      body: TefilaWidget(
        getBracha: getBracha,
        isWithNosah: false,
      ),
    );
  }

  late final Map<String, Map<Nosah, List<String>>> getBracha = {
    'he': brachaHeb,
    'en': brachaEn,
  };

  final Map<Nosah, List<String>> brachaHeb = {
    Nosah.mizrah: const [
      'קריאת שמע על המיטה',
      'Tבִּרְכַּת הַמַּפִּיל',
      'Sבָּרוּךְ אַתָּה יְיָ אֱלֹהֵינוּ מֶלֶךְ הָעוֹלָם,',
      'הַמַּפִּיל חֶבְלֵי שֵׁנָה עַל עֵינַי, וּתְנוּמָה עַל עַפְעַפַּי.',
      'וּמֵאִיר לְאִישׁוֹן בַּת עַיִן.',
      'יְהִי רָצוֹן מִלְּפָנֶיךָ, יְיָ אֱלֹהַי וֵאלֹהֵי אֲבוֹתַי,',
      'שֶׁתַּשְׁכִּיבֵנִי לְשָׁלוֹם וְתַעֲמִידֵנִי לְשָׁלוֹם.',
      'וְאַל יְבַהֲלוּנִי רַעְיוֹנַי וַחֲלוֹמוֹת רָעִים וְהִרְהוּרִים רָעִים.',
      'וּתְהֵא מִטָּתִי שְׁלֵמָה לְפָנֶיךָ.',
      'וְהָאֵר עֵינַי פֶּן אִישַׁן הַמָּוֶת.',
      'Sבָּרוּךְ אַתָּה יְיָ, הַמֵּאִיר לָעוֹלָם כֻּלּוֹ בִּכְבוֹדוֹ.',
      'Tשְׁמַע יִשְׂרָאֵל',
      'Sשְׁמַע יִשְׂרָאֵל יְיָ אֱלֹהֵינוּ יְיָ אֶחָד.',
      'בָּרוּךְ שֵׁם כְּבוֹד מַלְכוּתוֹ לְעוֹלָם וָעֶד.',
      'Tוְאָהַבְתָּ',
      'Sוְאָהַבְתָּ אֵת יְיָ אֱלֹהֶיךָ,',
      'בְּכָל לְבָבְךָ וּבְכָל נַפְשְׁךָ וּבְכָל מְאֹדֶךָ.',
      'וְהָיוּ הַדְּבָרִים הָאֵלֶּה, אֲשֶׁר אָנֹכִי מְצַוְּךָ הַיּוֹם, עַל לְבָבֶךָ.',
      'וְשִׁנַּנְתָּם לְבָנֶיךָ וְדִבַּרְתָּ בָּם,',
      'בְּשִׁבְתְּךָ בְּבֵיתֶךָ וּבְלֶכְתְּךָ בַדֶּרֶךְ וּבְשָׁכְבְּךָ וּבְקוּמֶךָ.',
      'וּקְשַׁרְתָּם לְאוֹת עַל יָדֶךָ, וְהָיוּ לְטֹטָפֹת בֵּין עֵינֶיךָ.',
      'וּכְתַבְתָּם עַל מְזוּזֹת בֵּיתֶךָ וּבִשְׁעָרֶיךָ.',
      'Tהַמַּלְאָכִים',
      'Sבְּשֵׁם יְיָ אֱלֹהֵי יִשְׂרָאֵל:',
      'מִימִינִי מִיכָאֵל, וּמִשְּׂמֹאלִי גַבְרִיאֵל,',
      'וּמִלְּפָנַי אוּרִיאֵל, וּמֵאַחוֹרַי רְפָאֵל,',
      'וְעַל רֹאשִׁי שְׁכִינַת אֵל.',
      'Tיְהִי שָׁלוֹם',
      'Sיְהִי שָׁלוֹם בְּחֵילֵךְ, שַׁלְוָה בְּאַרְמְנוֹתָיִךְ.',
      'לְמַעַן אַחַי וְרֵעָי, אֲדַבְּרָה נָּא שָׁלוֹם בָּךְ.',
      'לְמַעַן בֵּית יְיָ אֱלֹהֵינוּ, אֲבַקְשָׁה טוֹב לָךְ.',
    ],
  };

  final Map<Nosah, List<String>> brachaEn = {
    Nosah.mizrah: const [
      'Bedtime Shema',
      'TThe Hamapil Blessing',
      'SBlessed are You, Lord our God, King of the universe,',
      'who brings sleep to my eyes and slumber to my eyelids.',
      'May it be Your will, Lord my God and God of my ancestors,',
      'that You lay me down in peace and raise me up in peace.',
      'Let no bad thoughts, bad dreams or bad reflections disturb me.',
      'SBlessed are You, Lord, who illuminates the entire world with His glory.',
      'TShema Yisrael',
      'SHear O Israel, the Lord is our God, the Lord is One.',
      'Blessed be the name of His glorious Kingdom forever and ever.',
      'TThe Love Commandment (V\'ahavta)',
      'SYou shall love the Lord your God with all your heart,',
      'with all your soul and with all your might.',
      'These words which I command you today shall be on your heart.',
      'TThe Angels',
      'SIn the name of the Lord God of Israel:',
      'To my right is Michael, to my left is Gabriel,',
      'before me is Uriel, behind me is Raphael,',
      'and above my head is the Divine Presence of God.',
    ],
  };
}
