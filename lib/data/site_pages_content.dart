import 'package:kodesh_app/config/site_contact.dart';
import 'package:kodesh_app/models/info_page_section.dart';

/// Long-form content for the About, Accessibility statement and Privacy
/// policy pages, keyed by language code. Languages without a translation fall
/// back to English.
class SitePagesContent {
  SitePagesContent._();

  /// Date the accessibility statement and privacy policy were last reviewed.
  static const String lastUpdatedHe = '25 באוקטובר 2026';
  static const String lastUpdatedEn = 'October 25, 2026';

  static List<InfoPageSection> about(String lang) =>
      _about[lang] ?? _about['en']!;

  static List<InfoPageSection> accessibility(String lang) =>
      lang == 'he' ? _accessibilityHe() : _accessibilityEn();

  static List<InfoPageSection> privacy(String lang) =>
      lang == 'he' ? _privacyHe() : _privacyEn();

  // ---------------------------------------------------------------------------
  // About
  // ---------------------------------------------------------------------------

  static const Map<String, List<InfoPageSection>> _about = {
    'he': [
      InfoPageSection(
        paragraphs: [
          'קודש מרכזת במקום אחד את מה שצריך לשבת, לחג וליום יום: זמני כניסת השבת ויציאתה, זמני החגים, זמני היום ההלכתיים, לוח חגים, דף יומי ותפילות.',
        ],
      ),
      InfoPageSection(
        title: 'מה יש כאן',
        paragraphs: [
          '• זמני הדלקת נרות והבדלה לכל שבת וחג, לפי העיר שבחרתם או לפי המיקום שלכם.',
          '• זמני היום: עלות השחר, הנץ החמה, סוף זמן קריאת שמע, שקיעה, צאת הכוכבים ועוד.',
          '• לוח חגים שנתי וחודשי, ראש חודש, ספירת העומר ומולד הלבנה.',
          '• סדר הדלקת נרות, הבדלה, הנחת תפילין, ברכת המזון, קריאת שמע על המיטה ועוד, בנוסחים ספרד, אשכנז ועדות המזרח.',
          '• באפליקציה לטלפון: תזכורות לשבת, לחגים, לתפילין, לראש חודש ולספירת העומר, ומצפן.',
        ],
      ),
      InfoPageSection(
        title: 'מקורות המידע',
        paragraphs: [
          'זמני השבת, החגים וזמני היום מגיעים מ-Hebcal.com (Hebcal Jewish Calendar), בכפוף לרישיון Creative Commons Attribution 4.0.',
          'הדף היומי מגיע מספריא (Sefaria.org).',
          'זיהוי העיר לפי מיקום נעשה בעזרת OpenStreetMap Nominatim.',
        ],
      ),
      InfoPageSection(
        title: 'חשוב לדעת',
        paragraphs: [
          'הזמנים מחושבים אוטומטית ועשויים להשתנות לפי המנהג והמקום המדויק. בשאלות הלכתיות ובמקרה של ספק יש לבדוק מול לוח מקומי או רב.',
          'התזכורות באפליקציה תלויות במכשיר ובהגדרותיו ועלולות שלא להגיע בזמן, ולכן אין להסתמך עליהן בלבד.',
        ],
      ),
    ],
    'en': [
      InfoPageSection(
        paragraphs: [
          'Kodesh brings together what you need for Shabbat, holidays and every day: candle lighting and Havdalah times, holiday dates, halachic times of day, a holiday calendar, Daf Yomi and prayers.',
        ],
      ),
      InfoPageSection(
        title: 'What you will find here',
        paragraphs: [
          '• Candle lighting and Havdalah times for every Shabbat and holiday, for the city you choose or your current location.',
          '• Times of day: dawn, sunrise, latest Shema, sunset, nightfall and more.',
          '• Yearly and monthly holiday calendar, Rosh Chodesh, Sefirat HaOmer and the Molad.',
          '• Candle lighting, Havdalah, putting on tefillin, Birkat HaMazon, the bedtime Shema and more, in the Sefard, Ashkenaz and Edot HaMizrach traditions.',
          '• In the phone app: reminders for Shabbat, holidays, tefillin, Rosh Chodesh and the Omer, and a compass.',
        ],
      ),
      InfoPageSection(
        title: 'Data sources',
        paragraphs: [
          'Shabbat, holiday and daily times come from Hebcal.com (Hebcal Jewish Calendar), licensed under Creative Commons Attribution 4.0.',
          'Daf Yomi comes from Sefaria.org.',
          'Finding your city from your location uses OpenStreetMap Nominatim.',
        ],
      ),
      InfoPageSection(
        title: 'Please note',
        paragraphs: [
          'Times are calculated automatically and can vary by custom and exact location. For halachic questions or when in doubt, check a local calendar or ask a rabbi.',
          'Reminders in the app depend on your device and its settings and may not arrive on time, so please do not rely on them alone.',
        ],
      ),
    ],
    'es': [
      InfoPageSection(
        paragraphs: [
          'Kodesh reúne lo que necesitas para Shabat, las festividades y cada día: horarios de encendido de velas y Havdalá, fechas de festividades, horarios halájicos del día, calendario de festividades, Daf Yomi y oraciones.',
        ],
      ),
      InfoPageSection(
        title: 'Fuentes de datos',
        paragraphs: [
          'Los horarios provienen de Hebcal.com (Hebcal Jewish Calendar), con licencia Creative Commons Attribution 4.0. El Daf Yomi proviene de Sefaria.org. La búsqueda de ciudad por ubicación usa OpenStreetMap Nominatim.',
        ],
      ),
      InfoPageSection(
        title: 'Importante',
        paragraphs: [
          'Los horarios se calculan automáticamente y pueden variar según la costumbre y la ubicación exacta. Ante cualquier duda, consulta un calendario local o a un rabino. Los recordatorios de la aplicación pueden no llegar a tiempo; no dependas solo de ellos.',
        ],
      ),
    ],
    'ru': [
      InfoPageSection(
        paragraphs: [
          'Kodesh собирает в одном месте всё нужное для Шабата, праздников и каждого дня: время зажигания свечей и Авдалы, даты праздников, галахическое время дня, календарь праздников, Даф Йоми и молитвы.',
        ],
      ),
      InfoPageSection(
        title: 'Источники данных',
        paragraphs: [
          'Время берётся с Hebcal.com (Hebcal Jewish Calendar) по лицензии Creative Commons Attribution 4.0. Даф Йоми — с Sefaria.org. Определение города по местоположению — через OpenStreetMap Nominatim.',
        ],
      ),
      InfoPageSection(
        title: 'Важно',
        paragraphs: [
          'Время рассчитывается автоматически и может отличаться в зависимости от обычая и точного места. При сомнениях сверяйтесь с местным календарём или раввином. Напоминания в приложении могут прийти с опозданием, не полагайтесь только на них.',
        ],
      ),
    ],
  };

  // ---------------------------------------------------------------------------
  // Accessibility statement
  // ---------------------------------------------------------------------------

  static List<String> _contactLinesHe() => [
    if (SiteContact.accessibilityCoordinatorName.isNotEmpty)
      'רכז/ת נגישות: ${SiteContact.accessibilityCoordinatorName}',
    if (SiteContact.email.isNotEmpty) 'דוא"ל: ${SiteContact.email}',
    if (SiteContact.phone.isNotEmpty) 'טלפון: ${SiteContact.phone}',
  ];

  static List<String> _contactLinesEn() => [
    if (SiteContact.accessibilityCoordinatorName.isNotEmpty)
      'Accessibility coordinator: ${SiteContact.accessibilityCoordinatorName}',
    if (SiteContact.email.isNotEmpty) 'Email: ${SiteContact.email}',
    if (SiteContact.phone.isNotEmpty) 'Phone: ${SiteContact.phone}',
  ];

  static List<InfoPageSection> _accessibilityHe() => [
    const InfoPageSection(
      paragraphs: [
        'אנו רואים חשיבות רבה במתן שירות שוויוני לכל המשתמשים, ובכלל זה לאנשים עם מוגבלות. האתר הונגש בהתאם לתקנות שוויון זכויות לאנשים עם מוגבלות (התאמות נגישות לשירות), התשע"ג-2013, ולתקן הישראלי ת"י 5568 המבוסס על הנחיות WCAG 2.0 ברמה AA.',
      ],
    ),
    const InfoPageSection(
      title: 'מה עשינו כדי להנגיש את האתר',
      paragraphs: [
        '• תמיכה בקוראי מסך: לכל כפתור ופקד יש תיאור, כותרות מסומנות ככותרות, ותמונות דקורטיביות מוסתרות מקוראי מסך.',
        '• ניווט מלא באמצעות המקלדת (Tab, Shift+Tab, Enter ורווח).',
        '• שפת העמוד מוגדרת לפי השפה שנבחרה, ותצוגה מימין לשמאל בעברית.',
        '• האתר מותאם לטלפונים, לטאבלטים ולמחשבים, ותומך בהגדלת התצוגה בדפדפן עד 200% בלי לאבד תוכן.',
        '• בעמודי התפילות יש כפתורים להגדלה ולהקטנה של הטקסט.',
        '• תמיכה במצב כהה ובניגודיות צבעים מתאימה.',
      ],
    ),
    const InfoPageSection(
      title: 'מגבלות ידועות',
      paragraphs: [
        '• האתר בנוי בטכנולוגיית Flutter. ייתכן שחלק מקוראי המסך הישנים לא יתמכו בכל הרכיבים באופן מלא.',
        '• קישורים לאתרים חיצוניים (כמו ספריא) מובילים לתוכן שאינו בשליטתנו.',
        '• התזכורות והמצפן זמינים רק באפליקציה לטלפון.',
        'אם נתקלתם ברכיב שאינו נגיש, נשמח שתעדכנו אותנו ונפעל לתקן אותו.',
      ],
    ),
    const InfoPageSection(
      title: 'איך בדקנו',
      paragraphs: [
        'האתר נבדק בבדיקות נגישות אוטומטיות (axe-core) ובבדיקות ידניות של ניווט במקלדת ושל תצוגה בגדלי מסך שונים ובהגדלה של 200%, בדפדפן Chrome.',
      ],
    ),
    InfoPageSection(
      title: 'פנייה בנושא נגישות',
      paragraphs: [
        'נתקלתם בבעיית נגישות או שיש לכם הצעה לשיפור? נשמח לשמוע. כדי שנוכל לטפל בפנייה, נשמח לקבל תיאור של הבעיה, את העמוד שבו נתקלתם בה, ואת הדפדפן ותוכנת ההקראה (אם יש) שבהם השתמשתם.',
        ..._contactLinesHe(),
      ],
    ),
    const InfoPageSection(
      paragraphs: ['הצהרת הנגישות עודכנה לאחרונה: $lastUpdatedHe.'],
    ),
  ];

  static List<InfoPageSection> _accessibilityEn() => [
    const InfoPageSection(
      paragraphs: [
        'We want everyone, including people with disabilities, to be able to use this site. It was made accessible in line with the Israeli Equal Rights for Persons with Disabilities (Service Accessibility Adjustments) Regulations, 2013, and Israeli Standard IS 5568, which is based on WCAG 2.0 level AA.',
      ],
    ),
    const InfoPageSection(
      title: 'What we did',
      paragraphs: [
        '• Screen reader support: every button and control has a label, headings are marked as headings, and decorative images are hidden from screen readers.',
        '• Full keyboard navigation (Tab, Shift+Tab, Enter and Space).',
        '• The page language follows the language you choose, with right-to-left layout in Hebrew.',
        '• The site works on phones, tablets and computers, and supports browser zoom up to 200% without losing content.',
        '• Prayer pages have buttons to make the text larger or smaller.',
        '• Dark mode and adequate color contrast.',
      ],
    ),
    const InfoPageSection(
      title: 'Known limitations',
      paragraphs: [
        '• The site is built with Flutter. Some older screen readers may not fully support every component.',
        '• Links to external sites (such as Sefaria) lead to content we do not control.',
        '• Reminders and the compass are only available in the phone app.',
        'If you find something that is not accessible, please let us know and we will work to fix it.',
      ],
    ),
    const InfoPageSection(
      title: 'How we tested',
      paragraphs: [
        'The site was checked with automated accessibility testing (axe-core) and manual checks of keyboard navigation, different screen sizes and 200% zoom, in Chrome.',
      ],
    ),
    InfoPageSection(
      title: 'Contact us about accessibility',
      paragraphs: [
        'Found an accessibility problem or have a suggestion? We would like to hear from you. Please tell us what the problem is, which page it was on, and which browser and screen reader (if any) you used.',
        ..._contactLinesEn(),
      ],
    ),
    const InfoPageSection(
      paragraphs: ['This statement was last updated on $lastUpdatedEn.'],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Privacy policy
  // ---------------------------------------------------------------------------

  static List<InfoPageSection> _privacyHe() => [
    const InfoPageSection(
      paragraphs: [
        'פרטיותכם חשובה לנו. האתר פועל בלי הרשמה, בלי עוגיות מעקב ובלי כלי ניתוח או פרסום, ואין לנו שרת שאוסף עליכם מידע.',
      ],
    ),
    const InfoPageSection(
      title: 'מה נשמר ואיפה',
      paragraphs: [
        'ההעדפות שלכם, כמו שפה, עיר, אפשרויות תצוגה ורשימת המטלות לפני שבת, נשמרות רק בדפדפן שלכם (Local Storage). הן לא נשלחות אלינו, ואפשר למחוק אותן בכל עת על ידי ניקוי נתוני האתר בדפדפן.',
      ],
    ),
    const InfoPageSection(
      title: 'מיקום',
      paragraphs: [
        'אם תבחרו להשתמש במיקום שלכם, הדפדפן יבקש את אישורכם. המיקום משמש רק כדי למצוא את העיר הקרובה ולחשב את הזמנים: הקואורדינטות נשלחות ל-OpenStreetMap Nominatim ול-Hebcal לצורך זה בלבד, ואינן נשמרות אצלנו. אפשר לבחור עיר מהרשימה בלי לשתף מיקום.',
      ],
    ),
    const InfoPageSection(
      title: 'שירותים חיצוניים',
      paragraphs: [
        'כדי להציג את התוכן, הדפדפן שלכם פונה ישירות לשירותים הבאים, שכל אחד מהם פועל לפי מדיניות הפרטיות שלו:',
        '• Hebcal.com – זמני שבת, חגים וזמני היום.',
        '• Sefaria.org – הדף היומי.',
        '• OpenStreetMap Nominatim – זיהוי עיר לפי מיקום (רק אם בחרתם בכך).',
        '• Google (gstatic.com) – רכיבי תצוגה וגופנים שהאתר טוען.',
        '• ספק האחסון של האתר – עשוי לרשום ביומני השרת פרטים טכניים כמו כתובת IP וסוג הדפדפן.',
      ],
    ),
    InfoPageSection(
      title: 'יצירת קשר',
      paragraphs: [
        'שאלות בנושא פרטיות?',
        if (SiteContact.email.isNotEmpty) 'דוא"ל: ${SiteContact.email}',
      ],
    ),
    const InfoPageSection(
      paragraphs: ['מדיניות הפרטיות עודכנה לאחרונה: $lastUpdatedHe.'],
    ),
  ];

  static List<InfoPageSection> _privacyEn() => [
    const InfoPageSection(
      paragraphs: [
        'Your privacy matters to us. The site works without registration, tracking cookies, analytics or advertising tools, and we have no server that collects information about you.',
      ],
    ),
    const InfoPageSection(
      title: 'What is stored and where',
      paragraphs: [
        'Your preferences, such as language, city, display options and your pre-Shabbat task list, are stored only in your browser (Local Storage). They are not sent to us, and you can delete them at any time by clearing this site\'s data in your browser.',
      ],
    ),
    const InfoPageSection(
      title: 'Location',
      paragraphs: [
        'If you choose to use your location, your browser will ask for permission. Your location is used only to find the nearest city and calculate times: the coordinates are sent to OpenStreetMap Nominatim and Hebcal for that purpose only and are not stored by us. You can pick a city from the list instead of sharing your location.',
      ],
    ),
    const InfoPageSection(
      title: 'External services',
      paragraphs: [
        'To show its content, your browser contacts the following services directly. Each has its own privacy policy:',
        '• Hebcal.com – Shabbat, holiday and daily times.',
        '• Sefaria.org – Daf Yomi.',
        '• OpenStreetMap Nominatim – finding your city from your location (only if you choose to).',
        '• Google (gstatic.com) – display components and fonts the site loads.',
        '• The site\'s hosting provider – may record technical details such as IP address and browser type in server logs.',
      ],
    ),
    InfoPageSection(
      title: 'Contact',
      paragraphs: [
        'Questions about privacy?',
        if (SiteContact.email.isNotEmpty) 'Email: ${SiteContact.email}',
      ],
    ),
    const InfoPageSection(
      paragraphs: ['This policy was last updated on $lastUpdatedEn.'],
    ),
  ];
}
