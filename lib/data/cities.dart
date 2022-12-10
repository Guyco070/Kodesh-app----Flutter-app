const cities = [
  {
    'en': 'AD-Andorra La Vella',
    'he': 'AD-אנדורה לה ולה',
    'ru': 'AD-Андорра-ла-Велья',
    'es': 'AD-Andorra La Vella',
    'eNameAndCode': 'AD-Andorra La Vella|3041563'
  },
  {
    'en': 'AE-Abu Dhabi',
    'he': 'AE-אבו דאבי',
    'ru': 'AE-Абу Даби',
    'es': 'AE-Abu Dhabi',
    'eNameAndCode': 'AE-Abu Dhabi|292968'
  },
  {
    'en': 'AE-Dubai',
    'he': 'AE-דובאי',
    'ru': 'AE-Дубай',
    'es': 'AE-Dubái',
    'eNameAndCode': 'AE-Dubai|292223'
  },
  {
    'en': 'AF-Kabul',
    'he': 'AF-קאבול',
    'ru': 'AF-Кабул',
    'es': 'AF-Kabul',
    'eNameAndCode': 'AF-Kabul|1138958'
  },
  {
    'en': 'AI-The Valley',
    'he': 'AI-העמק',
    'ru': 'AI-Долина',
    'es': 'AI-El valle',
    'eNameAndCode': 'AI-The Valley|3573374'
  },
  {
    'en': 'AL-Tirana',
    'he': 'AL-טירנה',
    'ru': 'AL-Тирана',
    'es': 'AL-Tirana',
    'eNameAndCode': 'AL-Tirana|3183875'
  },
  {
    'en': 'AM-Yerevan',
    'he': 'AM-ירוואן',
    'ru': 'AM-Ереван',
    'es': 'AM-Ereván',
    'eNameAndCode': 'AM-Yerevan|616052'
  },
  {
    'en': 'AO-Luanda',
    'he': 'AO-לואנדה',
    'ru': 'AO-Луанда',
    'es': 'AO-Luanda',
    'eNameAndCode': 'AO-Luanda|2240449'
  },
  {
    'en': 'AR-Buenos Aires',
    'he': 'AR-בואנוס איירס',
    'ru': 'AR-Буэнос айрес',
    'es': 'AR-Buenos Aires',
    'eNameAndCode': 'AR-Buenos Aires|3435910'
  },
  {
    'en': 'AR-Cordoba',
    'he': 'AR-קורדובה',
    'ru': 'AR-Кордова',
    'es': 'AR-córdoba',
    'eNameAndCode': 'AR-Cordoba|3860259'
  },
  {
    'en': 'AR-Rosario',
    'he': 'AR-רוסריו',
    'ru': 'AR-Росарио',
    'es': 'AR-Rosario',
    'eNameAndCode': 'AR-Rosario|3838583'
  },
  {
    'en': 'AS-Pago Pago',
    'he': 'AS-פאגו פאגו',
    'ru': 'AS-Паго-Паго',
    'es': 'AS-pago pago',
    'eNameAndCode': 'AS-Pago Pago|5881576'
  },
  {
    'en': 'AT-Vienna',
    'he': 'AT-וינה',
    'ru': 'AT-Вена',
    'es': 'AT-Viena',
    'eNameAndCode': 'AT-Vienna|2761369'
  },
  {
    'en': 'AU-Adelaide',
    'he': 'AU-אדלייד',
    'ru': 'AU-Аделаида',
    'es': 'AU-Adelaida',
    'eNameAndCode': 'AU-Adelaide|2078025'
  },
  {
    'en': 'AU-Brisbane',
    'he': 'AU-בריסביין',
    'ru': 'AU-Брисбен',
    'es': 'AU-Brisbane',
    'eNameAndCode': 'AU-Brisbane|2174003'
  },
  {
    'en': 'AU-Canberra',
    'he': 'AU-קנברה',
    'ru': 'AU-Канберра',
    'es': 'AU-Canberra',
    'eNameAndCode': 'AU-Canberra|2172517'
  },
  {
    'en': 'AU-Gold Coast',
    'he': 'AU-חוף זהב',
    'ru': 'AU-Золотое побережье',
    'es': 'AU-Costa Dorada',
    'eNameAndCode': 'AU-Gold Coast|2165087'
  },
  {
    'en': 'AU-Hobart',
    'he': 'AU-הובארט',
    'ru': 'AU-Хобарт',
    'es': 'AU-Hobart',
    'eNameAndCode': 'AU-Hobart|2163355'
  },
  {
    'en': 'AU-Melbourne',
    'he': 'AU-מלבורן',
    'ru': 'AU-Мельбурн',
    'es': 'AU-melbourne',
    'eNameAndCode': 'AU-Melbourne|2158177'
  },
  {
    'en': 'AU-Perth',
    'he': 'AU-פרת',
    'ru': 'AU-Перт',
    'es': 'AU-Perth',
    'eNameAndCode': 'AU-Perth|2063523'
  },
  {
    'en': 'AU-Sydney',
    'he': 'AU-סידני',
    'ru': 'AU-Сидней',
    'es': 'AU-Sídney',
    'eNameAndCode': 'AU-Sydney|2147714'
  },
  {
    'en': 'AW-Oranjestad',
    'he': "AW-אורנג'סטאד",
    'ru': 'AW-Ораньестад',
    'es': 'AW-Oranjestad',
    'eNameAndCode': 'AW-Oranjestad|3577154'
  },
  {
    'en': 'AZ-Baku',
    'he': 'AZ-באקו',
    'ru': 'AZ-Баку',
    'es': 'AZ-Bakú',
    'eNameAndCode': 'AZ-Baku|587084'
  },
  {
    'en': 'BA-Sarajevo',
    'he': 'BA-סרייבו',
    'ru': 'BA-Сараево',
    'es': 'BA-sarajevo',
    'eNameAndCode': 'BA-Sarajevo|3191281'
  },
  {
    'en': 'BB-Bridgetown',
    'he': "BB-ברידג'טאון",
    'ru': 'BB-Бриджтаун',
    'es': 'BB-Bridgetown',
    'eNameAndCode': 'BB-Bridgetown|3374036'
  },
  {
    'en': 'BD-Chittagong',
    'he': "BD-צ'יטגונג",
    'ru': 'BD-Читтагонг',
    'es': 'BD-Chittagong',
    'eNameAndCode': 'BD-Chittagong|1205733'
  },
  {
    'en': 'BD-Dhaka',
    'he': 'BD-דאקה',
    'ru': 'BD-Дакка',
    'es': 'BD-Daca',
    'eNameAndCode': 'BD-Dhaka|1185241'
  },
  {
    'en': 'BD-Khulna',
    'he': 'BD-חולנה',
    'ru': 'BD-Кхулна',
    'es': 'BD-Khulna',
    'eNameAndCode': 'BD-Khulna|1336135'
  },
  {
    'en': 'BE-Brussels',
    'he': 'BE-בריסל',
    'ru': 'BE-Брюссель',
    'es': 'BE-Bruselas',
    'eNameAndCode': 'BE-Brussels|2800866'
  },
  {
    'en': 'BF-Ouagadougou',
    'he': 'BF-אואגדו',
    'ru': 'BF-Уагадугу',
    'es': 'BF-Uagadugú',
    'eNameAndCode': 'BF-Ouagadougou|2357048'
  },
  {
    'en': 'BG-Sofia',
    'he': 'BG-סופיה',
    'ru': 'BG-София',
    'es': 'BG-Sofía',
    'eNameAndCode': 'BG-Sofia|727011'
  },
  {
    'en': 'BH-Manama',
    'he': 'BH-מנאמה',
    'ru': 'BH-Манама',
    'es': 'BH-manama',
    'eNameAndCode': 'BH-Manama|290340'
  },
  {
    'en': 'BI-Bujumbura',
    'he': "BI-בוג'ומבורה",
    'ru': 'BI-Бужумбура',
    'es': 'BI-Buyumbura',
    'eNameAndCode': 'BI-Bujumbura|425378'
  },
  {
    'en': 'BJ-Porto-novo',
    'he': 'BJ-פורטו',
    'ru': 'BJ-Порту',
    'es': 'BJ-Oporto',
    'eNameAndCode': 'BJ-Porto-novo|2392087'
  },
  {
    'en': 'BM-Hamilton',
    'he': 'BM-המילטון',
    'ru': 'BM-Гамильтон',
    'es': 'BM-hamilton',
    'eNameAndCode': 'BM-Hamilton|3573197'
  },
  {
    'en': 'BN-Bandar Seri Begawan',
    'he': 'BN-בנדר סרי בגוואן',
    'ru': 'BN-Бандар-Сери-Бегаван',
    'es': 'BN-Bandar Seri Begawan',
    'eNameAndCode': 'BN-Bandar Seri Begawan|1820906'
  },
  {
    'en': 'BO-La Paz',
    'he': 'BO-לה פז',
    'ru': 'BO-Ла-Пас',
    'es': 'BO-La Paz',
    'eNameAndCode': 'BO-La Paz|3911925'
  },
  {
    'en': 'BO-Santa Cruz de la Sierra',
    'he': 'BO-סנטה קרוז דה לה סיירה',
    'ru': 'BO-Санта-Крус-де-ла-Сьерра',
    'es': 'BO-santa cruz de la sierra',
    'eNameAndCode': 'BO-Santa Cruz de la Sierra|3904906'
  },
  {
    'en': 'BR-Belo Horizonte',
    'he': 'BR-בלו הוריזונטה',
    'ru': 'BR-Белу-Оризонти',
    'es': 'BR-Belo Horizonte',
    'eNameAndCode': 'BR-Belo Horizonte|3470127'
  },
  {
    'en': 'BR-Brasilia',
    'he': 'BR-ברזיליה',
    'ru': 'BR-Бразилиа',
    'es': 'BR-Brasilia',
    'eNameAndCode': 'BR-Brasilia|3469058'
  },
  {
    'en': 'BR-Fortaleza',
    'he': 'BR-פורטלזה',
    'ru': 'BR-Форталеза',
    'es': 'BR-Fortaleza',
    'eNameAndCode': 'BR-Fortaleza|3399415'
  },
  {
    'en': 'BR-Rio de Janeiro',
    'he': "BR-ריו דה ז'נרו",
    'ru': 'BR-Рио де Жанейро',
    'es': 'BR-Rio de Janeiro',
    'eNameAndCode': 'BR-Rio de Janeiro|3451190'
  },
  {
    'en': 'BR-Salvador',
    'he': 'BR-סלבדור',
    'ru': 'BR-Сальвадор',
    'es': 'BR-el Salvador',
    'eNameAndCode': 'BR-Salvador|3450554'
  },
  {
    'en': 'BR-Sao Paulo',
    'he': 'BR-סאו פאולו',
    'ru': 'BR-Сан-Паулу',
    'es': 'BR-Sao Paulo',
    'eNameAndCode': 'BR-Sao Paulo|3448439'
  },
  {
    'en': 'BS-Nassau',
    'he': 'BS-נסאו',
    'ru': 'BS-Нассау',
    'es': 'BS-Nassau',
    'eNameAndCode': 'BS-Nassau|3571824'
  },
  {
    'en': 'BT-Thimphu',
    'he': 'BT-Thimphu',
    'ru': 'BT-Тхимпху',
    'es': 'BT-Timbu',
    'eNameAndCode': 'BT-Thimphu|1252416'
  },
  {
    'en': 'BW-Gaborone',
    'he': 'BW-גאבורון',
    'ru': 'BW-Габороне',
    'es': 'BW-Gaborone',
    'eNameAndCode': 'BW-Gaborone|933773'
  },
  {
    'en': 'BY-Minsk',
    'he': 'BY-מינסק',
    'ru': 'BY-Минск',
    'es': 'BY-Minsk',
    'eNameAndCode': 'BY-Minsk|625144'
  },
  {
    'en': 'BZ-Belmopan',
    'he': 'BZ-בלמופן',
    'ru': 'BZ-Бельмопан',
    'es': 'BZ-Belmopán',
    'eNameAndCode': 'BZ-Belmopan|3582672'
  },
  {
    'en': 'CA-Calgary',
    'he': 'CA-קלגרי',
    'ru': 'CA-Калгари',
    'es': 'CA-Calgary',
    'eNameAndCode': 'CA-Calgary|5913490'
  },
  {
    'en': 'CA-Edmonton',
    'he': 'CA-אדמונטון',
    'ru': 'CA-Эдмонтон',
    'es': 'CA-edmonton',
    'eNameAndCode': 'CA-Edmonton|5946768'
  },
  {
    'en': 'CA-Halifax',
    'he': 'CA-הליפקס',
    'ru': 'CA-Галифакс',
    'es': 'CA-halifax',
    'eNameAndCode': 'CA-Halifax|6324729'
  },
  {
    'en': 'CA-Mississauga',
    'he': 'CA-מיססוגה',
    'ru': 'CA-Миссиссога',
    'es': 'CA-Mississauga',
    'eNameAndCode': 'CA-Mississauga|6075357'
  },
  {
    'en': 'CA-Montreal',
    'he': 'CA-מונטריאול',
    'ru': 'CA-Монреаль',
    'es': 'CA-Montréal',
    'eNameAndCode': 'CA-Montreal|6077243'
  },
  {
    'en': 'CA-Ottawa',
    'he': 'CA-אוטווה',
    'ru': 'CA-Оттава',
    'es': 'CA-Ottawa',
    'eNameAndCode': 'CA-Ottawa|6094817'
  },
  {
    'en': 'CA-Quebec City',
    'he': 'CA-העיר קוויבק',
    'ru': 'CA-Квебек',
    'es': 'CA-La ciudad de Quebec',
    'eNameAndCode': 'CA-Quebec City|6325494'
  },
  {
    'en': 'CA-Regina',
    'he': 'CA-רגינה',
    'ru': 'CA-Регина',
    'es': 'CA-regina',
    'eNameAndCode': 'CA-Regina|6119109'
  },
  {
    'en': 'CA-Saskatoon',
    'he': 'CA-ססקטון',
    'ru': 'CA-Саскатун',
    'es': 'CA-saskatoon',
    'eNameAndCode': 'CA-Saskatoon|6141256'
  },
  {
    'en': "CA-St. John's-05",
    'he': "CA-סנט ג'ון",
    'ru': 'CA-св. Джона',
    'es': 'CA-S t. Juan',
    'eNameAndCode': "CA-St. John's-05|6324733"
  },
  {
    'en': 'CA-Toronto',
    'he': 'CA-טורונטו',
    'ru': 'CA-Торонто',
    'es': 'CA-toronto',
    'eNameAndCode': 'CA-Toronto|6167865'
  },
  {
    'en': 'CA-Vancouver',
    'he': 'CA-ונקובר',
    'ru': 'CA-Ванкувер',
    'es': 'CA-vancouver',
    'eNameAndCode': 'CA-Vancouver|6173331'
  },
  {
    'en': 'CA-Victoria',
    'he': 'CA-ויקטוריה',
    'ru': 'CA-Виктория',
    'es': 'CA-Victoria',
    'eNameAndCode': 'CA-Victoria|6174041'
  },
  {
    'en': 'CA-Winnipeg',
    'he': 'CA-ויניפג',
    'ru': 'CA-Виннипег',
    'es': 'CA-Winnipeg',
    'eNameAndCode': 'CA-Winnipeg|6183235'
  },
  {
    'en': 'CD-Kinshasa',
    'he': 'CD-קינשאסה',
    'ru': 'CD-Киншаса',
    'es': 'CD-Kinsasa',
    'eNameAndCode': 'CD-Kinshasa|2314302'
  },
  {
    'en': 'CD-Lubumbashi',
    'he': 'CD-לובומבשי',
    'ru': 'CD-Лубумбаши',
    'es': 'CD-Lubumbashi',
    'eNameAndCode': 'CD-Lubumbashi|922704'
  },
  {
    'en': 'CF-Bangui',
    'he': 'CF-בנגוי',
    'ru': 'CF-Банги',
    'es': 'CF-bangui',
    'eNameAndCode': 'CF-Bangui|2389853'
  },
  {
    'en': 'CG-Brazzaville',
    'he': 'CG-ברזוויל',
    'ru': 'CG-Браззавиль',
    'es': 'CG-Brazzaville',
    'eNameAndCode': 'CG-Brazzaville|2260535'
  },
  {
    'en': 'CH-Bern',
    'he': 'CH-ברן',
    'ru': 'CH-Берн',
    'es': 'CH-Berna',
    'eNameAndCode': 'CH-Bern|2661552'
  },
  {
    'en': 'CH-Geneva',
    'he': "CH-ז'נבה",
    'ru': 'CH-Женева',
    'es': 'CH-Ginebra',
    'eNameAndCode': 'CH-Geneva|2660646'
  },
  {
    'en': 'CH-Zurich',
    'he': 'CH-ציריך',
    'ru': 'CH-Цюрих',
    'es': 'CH-Zúrich',
    'eNameAndCode': 'CH-Zurich|2657896'
  },
  {
    'en': 'CI-Abidjan',
    'he': "CI-אביג'אן",
    'ru': 'CI-Абиджан',
    'es': 'CI-Abiyán',
    'eNameAndCode': 'CI-Abidjan|2293538'
  },
  {
    'en': 'CI-Yamoussoukro',
    'he': 'CI-Yamoussoukro',
    'ru': 'CI-Ямусукро',
    'es': 'CI-Yamusukro',
    'eNameAndCode': 'CI-Yamoussoukro|2279755'
  },
  {
    'en': 'CK-Avarua',
    'he': 'CK-Avarua',
    'ru': 'CK-Аваруа',
    'es': 'CK-Avarua',
    'eNameAndCode': 'CK-Avarua|4035715'
  },
  {
    'en': 'CL-Santiago',
    'he': 'CL-סנטיאגו',
    'ru': 'CL-Сантьяго',
    'es': 'CL-santiago',
    'eNameAndCode': 'CL-Santiago|3871336'
  },
  {
    'en': 'CM-Douala',
    'he': 'CM-דואלה',
    'ru': 'CM-Дуала',
    'es': 'CM-Duala',
    'eNameAndCode': 'CM-Douala|2232593'
  },
  {
    'en': 'CM-Yaounde',
    'he': 'CM-יאונדה',
    'ru': 'CM-Яунде',
    'es': 'CM-Yaundé',
    'eNameAndCode': 'CM-Yaounde|2220957'
  },
  {
    'en': 'CN-Beijing',
    'he': "CN-בייג'ין",
    'ru': 'CN-Пекин',
    'es': 'CN-Beijing',
    'eNameAndCode': 'CN-Beijing|1816670'
  },
  {
    'en': 'CN-Chengdu',
    'he': "CN-צ'נגדו",
    'ru': 'CN-Чэнду',
    'es': 'CN-Chengdú',
    'eNameAndCode': 'CN-Chengdu|1815286'
  },
  {
    'en': 'CN-Chongqing',
    'he': "CN-צ'ונגצ'ינג",
    'ru': 'CN-Чунцин',
    'es': 'CN-Chongqing',
    'eNameAndCode': 'CN-Chongqing|1814906'
  },
  {
    'en': 'CN-Guangzhou',
    'he': "CN-גואנגג'ואו",
    'ru': 'CN-Гуанчжоу',
    'es': 'CN-Cantón',
    'eNameAndCode': 'CN-Guangzhou|1809858'
  },
  {
    'en': 'CN-Harbin',
    'he': 'CN-חרבין',
    'ru': 'CN-Харбин',
    'es': 'CN-Harbin',
    'eNameAndCode': 'CN-Harbin|2037013'
  },
  {
    'en': 'CN-Kaifeng',
    'he': 'CN-קאיפנג',
    'ru': 'CN-Кайфэн',
    'es': 'CN-Kaifeng',
    'eNameAndCode': 'CN-Kaifeng|1804879'
  },
  {
    'en': 'CN-Lanzhou',
    'he': "CN-לנז'ו",
    'ru': 'CN-Ланьчжоу',
    'es': 'CN-Lanzzhou',
    'eNameAndCode': 'CN-Lanzhou|1804430'
  },
  {
    'en': 'CN-Nanchong',
    'he': "CN-נאנצ'ונג",
    'ru': 'CN-Наньчун',
    'es': 'CN-Nanchong',
    'eNameAndCode': 'CN-Nanchong|1800146'
  },
  {
    'en': 'CN-Nanjing',
    'he': "CN-נאנג'ינג",
    'ru': 'CN-Нанкин',
    'es': 'CN-Nankín',
    'eNameAndCode': 'CN-Nanjing|1799962'
  },
  {
    'en': 'CN-Puyang',
    'he': 'CN-פויאנג',
    'ru': 'CN-Пуян',
    'es': 'CN-Puyang',
    'eNameAndCode': 'CN-Puyang|1798422'
  },
  {
    'en': 'CN-Shanghai',
    'he': 'CN-שנחאי',
    'ru': 'CN-Шанхай',
    'es': 'CN-Llevar a la fuerza',
    'eNameAndCode': 'CN-Shanghai|1796236'
  },
  {
    'en': 'CN-Shenyang',
    'he': 'CN-שניאנג',
    'ru': 'CN-Шэньян',
    'es': 'CN-Shenyáng',
    'eNameAndCode': 'CN-Shenyang|2034937'
  },
  {
    'en': 'CN-Shenzhen',
    'he': 'CN-שנזן',
    'ru': 'CN-Шэньчжэнь',
    'es': 'CN-Shenzhen',
    'eNameAndCode': 'CN-Shenzhen|1795565'
  },
  {
    'en': 'CN-Shiyan',
    'he': 'CN-שיאן',
    'ru': 'CN-Шиян',
    'es': 'CN-Shiyan',
    'eNameAndCode': 'CN-Shiyan|1794903'
  },
  {
    'en': "CN-Tai'an",
    'he': 'CN-טאיאן',
    'ru': 'CN-Тайань',
    'es': 'CN-Tai"an',
    'eNameAndCode': "CN-Tai'an|1793724"
  },
  {
    'en': 'CN-Tianjin',
    'he': "CN-טיאנג'ין",
    'ru': 'CN-Тяньцзинь',
    'es': 'CN-Tianjín',
    'eNameAndCode': 'CN-Tianjin|1792947'
  },
  {
    'en': 'CN-Wuhan',
    'he': 'CN-ווהאן',
    'ru': 'CN-Ухань',
    'es': 'CN-Wuhan',
    'eNameAndCode': 'CN-Wuhan|1791247'
  },
  {
    'en': "CN-Xi'an",
    'he': 'CN-שיאן',
    'ru': 'CN-Сиань',
    'es': 'CN-Xian',
    'eNameAndCode': "CN-Xi'an|1790630"
  },
  {
    'en': 'CN-Yueyang',
    'he': 'CN-יואיאנג',
    'ru': 'CN-Юэян',
    'es': 'CN-Yueyang',
    'eNameAndCode': 'CN-Yueyang|1927639'
  },
  {
    'en': 'CN-Zhumadian',
    'he': "CN-ז'ומדיאן",
    'ru': 'CN-Жумадиан',
    'es': 'CN-Zhumadian',
    'eNameAndCode': 'CN-Zhumadian|1783873'
  },
  {
    'en': 'CO-Barranquilla',
    'he': 'CO-ברנקייה',
    'ru': 'CO-Барранкилья',
    'es': 'CO-Barranquilla',
    'eNameAndCode': 'CO-Barranquilla|3689147'
  },
  {
    'en': 'CO-Bogota',
    'he': 'CO-בוגוטה',
    'ru': 'CO-Богота',
    'es': 'CO-Bogotá',
    'eNameAndCode': 'CO-Bogota|3688689'
  },
  {
    'en': 'CO-Cali',
    'he': 'CO-קאלי',
    'ru': 'CO-Кали',
    'es': 'CO-Cali',
    'eNameAndCode': 'CO-Cali|3687925'
  },
  {
    'en': 'CO-Medellin',
    'he': 'CO-מדין',
    'ru': 'CO-Медельин',
    'es': 'CO-Medellín',
    'eNameAndCode': 'CO-Medellin|3674962'
  },
  {
    'en': 'CR-San José',
    'he': 'CR-סאן חוזה',
    'ru': 'CR-Сан - Хосе',
    'es': 'CR-San Jose',
    'eNameAndCode': 'CR-San José|3621849'
  },
  {
    'en': 'CU-Havana',
    'he': 'CU-הוואנה',
    'ru': 'CU-Гавана',
    'es': 'CU-la Habana',
    'eNameAndCode': 'CU-Havana|3553478'
  },
  {
    'en': 'CV-Praia',
    'he': 'CV-פראיה',
    'ru': 'CV-Прая',
    'es': 'CV-Praia',
    'eNameAndCode': 'CV-Praia|3374333'
  },
  {
    'en': 'CW-Willemstad',
    'he': 'CW-וילמסטאד',
    'ru': 'CW-Виллемстад',
    'es': 'CW-Willemstad',
    'eNameAndCode': 'CW-Willemstad|3513090'
  },
  {
    'en': 'CY-Nicosia',
    'he': 'CY-ניקוסיה',
    'ru': 'CY-Никосия',
    'es': 'CY-nicosia',
    'eNameAndCode': 'CY-Nicosia|146268'
  },
  {
    'en': 'CZ-Prague',
    'he': 'CZ-פראג',
    'ru': 'CZ-Прага',
    'es': 'CZ-Praga',
    'eNameAndCode': 'CZ-Prague|3067696'
  },
  {
    'en': 'DE-Berlin',
    'he': 'DE-ברלין',
    'ru': 'DE-Берлин',
    'es': 'DE-Berlina',
    'eNameAndCode': 'DE-Berlin|2950159'
  },
  {
    'en': 'DE-Hamburg',
    'he': 'DE-המבורג',
    'ru': 'DE-Гамбург',
    'es': 'DE-Hamburgo',
    'eNameAndCode': 'DE-Hamburg|2911298'
  },
  {
    'en': 'DE-Munich',
    'he': 'DE-מינכן',
    'ru': 'DE-Мюнхен',
    'es': 'DE-Munich',
    'eNameAndCode': 'DE-Munich|2867714'
  },
  {
    'en': 'DK-Copenhagen',
    'he': 'DK-קופנהגן',
    'ru': 'DK-Копенгаген',
    'es': 'DK-Copenhague',
    'eNameAndCode': 'DK-Copenhagen|2618425'
  },
  {
    'en': 'DM-Roseau',
    'he': 'DM-רוזאו',
    'ru': 'DM-Розо',
    'es': 'DM-Roseau',
    'eNameAndCode': 'DM-Roseau|3575635'
  },
  {
    'en': 'DO-Santiago de los Caballeros',
    'he': 'DO-סנטיאגו דה לוס קבאלרוס',
    'ru': 'DO-Сантьяго-де-лос-Кабальерос',
    'es': 'DO-santiago de los caballeros',
    'eNameAndCode': 'DO-Santiago de los Caballeros|3492914'
  },
  {
    'en': 'DO-Santo Domingo',
    'he': 'DO-סנטו דומינגו',
    'ru': 'DO-Санто-Доминго',
    'es': 'DO-Santo Domingo',
    'eNameAndCode': 'DO-Santo Domingo|3492908'
  },
  {
    'en': 'DZ-Algiers',
    'he': "DZ-אלג'יר",
    'ru': 'DZ-Алжир',
    'es': 'DZ-Argel',
    'eNameAndCode': 'DZ-Algiers|2507480'
  },
  {
    'en': 'EC-Guayaquil',
    'he': 'EC-גואיאקיל',
    'ru': 'EC-Гуаякиль',
    'es': 'EC-guayaquil',
    'eNameAndCode': 'EC-Guayaquil|3657509'
  },
  {
    'en': 'EC-Quito',
    'he': 'EC-קיטו',
    'ru': 'EC-Кито',
    'es': 'EC-Quito',
    'eNameAndCode': 'EC-Quito|3652462'
  },
  {
    'en': 'EE-Tallinn',
    'he': 'EE-טאלין',
    'ru': 'EE-Таллинн',
    'es': 'EE-Tallin',
    'eNameAndCode': 'EE-Tallinn|588409'
  },
  {
    'en': 'EG-Al Jizah',
    'he': "EG-אל ג'יזה",
    'ru': 'EG-Аль Джиза',
    'es': 'EG-Al-Jizah',
    'eNameAndCode': 'EG-Al Jizah|360995'
  },
  {
    'en': 'EG-Alexandria',
    'he': 'EG-אלכסנדריה',
    'ru': 'EG-Александрия',
    'es': 'EG-Alejandría',
    'eNameAndCode': 'EG-Alexandria|361058'
  },
  {
    'en': 'EG-Cairo',
    'he': 'EG-קהיר',
    'ru': 'EG-Каир',
    'es': 'EG-El Cairo',
    'eNameAndCode': 'EG-Cairo|360630'
  },
  {
    'en': 'ER-Asmara',
    'he': 'ER-אסמרה',
    'ru': 'ER-Асмэра',
    'es': 'ER-Asmara',
    'eNameAndCode': 'ER-Asmara|343300'
  },
  {
    'en': 'ES-Barcelona',
    'he': 'ES-ברצלונה',
    'ru': 'ES-Барселона',
    'es': 'ES-Barcelona',
    'eNameAndCode': 'ES-Barcelona|3128760'
  },
  {
    'en': 'ES-Madrid',
    'he': 'ES-מדריד',
    'ru': 'ES-Мадрид',
    'es': 'ES-Madrid',
    'eNameAndCode': 'ES-Madrid|3117735'
  },
  {
    'en': 'ET-Addis Ababa',
    'he': 'ET-אדיס אבבה',
    'ru': 'ET-Аддис-Абеба',
    'es': 'ET-Addis Abeba',
    'eNameAndCode': 'ET-Addis Ababa|344979'
  },
  {
    'en': 'FI-Helsinki',
    'he': 'FI-הלסינקי',
    'ru': 'FI-Хельсинки',
    'es': 'FI-helsinki',
    'eNameAndCode': 'FI-Helsinki|658225'
  },
  {
    'en': 'FJ-Suva',
    'he': 'FJ-סובה',
    'ru': 'FJ-Сува',
    'es': 'FJ-Suva',
    'eNameAndCode': 'FJ-Suva|2198148'
  },
  {
    'en': 'FK-Stanley',
    'he': 'FK-סטנלי',
    'ru': 'FK-Стэнли',
    'es': 'FK-stanley',
    'eNameAndCode': 'FK-Stanley|3426691'
  },
  {
    'en': 'FO-Tórshavn',
    'he': 'FO-טורשאבן',
    'ru': 'FO-Торсхавн',
    'es': 'FO-Tórshavn',
    'eNameAndCode': 'FO-Tórshavn|2611396'
  },
  {
    'en': 'FR-Marseilles',
    'he': 'FR-מרסיי',
    'ru': 'FR-Марсель',
    'es': 'FR-Marsella',
    'eNameAndCode': 'FR-Marseilles|2995469'
  },
  {
    'en': 'FR-Paris',
    'he': 'FR-פריז',
    'ru': 'FR-Париж',
    'es': 'FR-París',
    'eNameAndCode': 'FR-Paris|2988507'
  },
  {
    'en': 'GA-Libreville',
    'he': 'GA-ליברוויל',
    'ru': 'GA-Либревиль',
    'es': 'GA-Libreville',
    'eNameAndCode': 'GA-Libreville|2399697'
  },
  {
    'en': 'GB-Belfast',
    'he': 'GB-בלפסט',
    'ru': 'GB-Белфаст',
    'es': 'GB-Belfast',
    'eNameAndCode': 'GB-Belfast|2655984'
  },
  {
    'en': 'GB-Birmingham',
    'he': 'GB-ברמינגהאם',
    'ru': 'GB-Бирмингем',
    'es': 'GB-Birmingham',
    'eNameAndCode': 'GB-Birmingham|2655603'
  },
  {
    'en': 'GB-Bristol',
    'he': 'GB-בריסטול',
    'ru': 'GB-Бристоль',
    'es': 'GB-Brístol',
    'eNameAndCode': 'GB-Bristol|2654675'
  },
  {
    'en': 'GB-Cardiff',
    'he': 'GB-קרדיף',
    'ru': 'GB-Кардифф',
    'es': 'GB-Cardiff',
    'eNameAndCode': 'GB-Cardiff|2653822'
  },
  {
    'en': 'GB-Edinburgh',
    'he': 'GB-אדינבורו',
    'ru': 'GB-Эдинбург',
    'es': 'GB-Edimburgo',
    'eNameAndCode': 'GB-Edinburgh|2650225'
  },
  {
    'en': 'GB-Glasgow',
    'he': 'GB-גלזגו',
    'ru': 'GB-Глазго',
    'es': 'GB-Glasgow',
    'eNameAndCode': 'GB-Glasgow|2648579'
  },
  {
    'en': 'GB-Leeds',
    'he': 'GB-לידס',
    'ru': 'GB-Лидс',
    'es': 'GB-Leeds',
    'eNameAndCode': 'GB-Leeds|2644688'
  },
  {
    'en': 'GB-Liverpool',
    'he': 'GB-ליברפול',
    'ru': 'GB-Ливерпуль',
    'es': 'GB-Liverpool',
    'eNameAndCode': 'GB-Liverpool|2644210'
  },
  {
    'en': 'GB-London',
    'he': 'GB-לונדון',
    'ru': 'GB-Лондон',
    'es': 'GB-Londres',
    'eNameAndCode': 'GB-London|2643743'
  },
  {
    'en': 'GB-Manchester',
    'he': "GB-מנצ'סטר",
    'ru': 'GB-Манчестер',
    'es': 'GB-Manchester',
    'eNameAndCode': 'GB-Manchester|2643123'
  },
  {
    'en': 'GB-Sheffield',
    'he': 'GB-שפילד',
    'ru': 'GB-Шеффилд',
    'es': 'GB-Sheffield',
    'eNameAndCode': 'GB-Sheffield|2638077'
  },
  {
    'en': 'GE-Tbilisi',
    'he': 'GE-טביליסי',
    'ru': 'GE-Тбилиси',
    'es': 'GE-Tiflis',
    'eNameAndCode': 'GE-Tbilisi|611717'
  },
  {
    'en': 'GH-Accra',
    'he': 'GH-אקרה',
    'ru': 'GH-Аккра',
    'es': 'GH-Acra',
    'eNameAndCode': 'GH-Accra|2306104'
  },
  {
    'en': 'GH-Kumasi',
    'he': 'GH-קומסי',
    'ru': 'GH-Кумаси',
    'es': 'GH-kumasi',
    'eNameAndCode': 'GH-Kumasi|2298890'
  },
  {
    'en': 'GI-Gibraltar',
    'he': 'GI-גיברלטר',
    'ru': 'GI-Гибралтар',
    'es': 'GI-Gibraltar',
    'eNameAndCode': 'GI-Gibraltar|2411585'
  },
  {
    'en': 'GL-Nuuk',
    'he': 'GL-נווק',
    'ru': 'GL-Нуук',
    'es': 'GL-Nuuk',
    'eNameAndCode': 'GL-Nuuk|3421319'
  },
  {
    'en': 'GM-Banjul',
    'he': "GM-בנג'ול",
    'ru': 'GM-Банжул',
    'es': 'GM-Banjul',
    'eNameAndCode': 'GM-Banjul|2413876'
  },
  {
    'en': 'GN-Camayenne',
    'he': 'GN-קמיין',
    'ru': 'GN-Камайенн',
    'es': 'GN-Camayena',
    'eNameAndCode': 'GN-Camayenne|2422488'
  },
  {
    'en': 'GN-Conakry',
    'he': 'GN-קונקרי',
    'ru': 'GN-Конакри',
    'es': 'GN-Conakri',
    'eNameAndCode': 'GN-Conakry|2422465'
  },
  {
    'en': 'GQ-Malabo',
    'he': 'GQ-מלאבו',
    'ru': 'GQ-Малабо',
    'es': 'GQ-Malabo',
    'eNameAndCode': 'GQ-Malabo|2309527'
  },
  {
    'en': 'GR-Athens',
    'he': 'GR-אַתוּנָה',
    'ru': 'GR-Афины',
    'es': 'GR-Atenas',
    'eNameAndCode': 'GR-Athens|264371'
  },
  {
    'en': 'GT-Guatemala City',
    'he': 'GT-עיר גואטמלה',
    'ru': 'GT-город Гватемала',
    'es': 'GT-Ciudad de Guatemala',
    'eNameAndCode': 'GT-Guatemala City|3598132'
  },
  {
    'en': 'GW-Bissau',
    'he': 'GW-ביסאו',
    'ru': 'GW-Бисау',
    'es': 'GW-Bisáu',
    'eNameAndCode': 'GW-Bissau|2374775'
  },
  {
    'en': 'GY-Georgetown',
    'he': "GY-ג'ורג'טאון",
    'ru': 'GY-Джорджтаун',
    'es': 'GY-georgetown',
    'eNameAndCode': 'GY-Georgetown|3378644'
  },
  {
    'en': 'HK-Hong Kong',
    'he': 'HK-הונג קונג',
    'ru': 'HK-Гонконг',
    'es': 'HK-Hong Kong',
    'eNameAndCode': 'HK-Hong Kong|1819729'
  },
  {
    'en': 'HN-Tegucigalpa',
    'he': 'HN-טגוסיגלפה',
    'ru': 'HN-Тегусигальпа',
    'es': 'HN-Tegucigalpa',
    'eNameAndCode': 'HN-Tegucigalpa|3600949'
  },
  {
    'en': 'HR-Zagreb',
    'he': 'HR-זאגרב',
    'ru': 'HR-Загреб',
    'es': 'HR-Zagreb',
    'eNameAndCode': 'HR-Zagreb|3186886'
  },
  {
    'en': 'HT-Port-au-Prince',
    'he': 'HT-נמל',
    'ru': 'HT-Порт',
    'es': 'HT-Puerto',
    'eNameAndCode': 'HT-Port-au-Prince|3718426'
  },
  {
    'en': 'HU-Budapest',
    'he': 'HU-בודפשט',
    'ru': 'HU-Будапешт',
    'es': 'HU-budapest',
    'eNameAndCode': 'HU-Budapest|3054643'
  },
  {
    'en': 'ID-Bandung',
    'he': 'ID-בנדונג',
    'ru': 'ID-Бандунг',
    'es': 'ID-Bandung',
    'eNameAndCode': 'ID-Bandung|1650357'
  },
  {
    'en': 'ID-Bekasi',
    'he': 'ID-בקסי',
    'ru': 'ID-Бекаси',
    'es': 'ID-Bekasi',
    'eNameAndCode': 'ID-Bekasi|1649378'
  },
  {
    'en': 'ID-Depok',
    'he': 'ID-דפוק',
    'ru': 'ID-Депок',
    'es': 'ID-depósito',
    'eNameAndCode': 'ID-Depok|1645518'
  },
  {
    'en': 'ID-Jakarta',
    'he': "ID-ג'קרטה",
    'ru': 'ID-Джакарта',
    'es': 'ID-Jacarta',
    'eNameAndCode': 'ID-Jakarta|1642911'
  },
  {
    'en': 'ID-Makassar',
    'he': 'ID-מקאסר',
    'ru': 'ID-Макассар',
    'es': 'ID-Macasar',
    'eNameAndCode': 'ID-Makassar|1622786'
  },
  {
    'en': 'ID-Medan',
    'he': 'ID-מדן',
    'ru': 'ID-Медан',
    'es': 'ID-medan',
    'eNameAndCode': 'ID-Medan|1214520'
  },
  {
    'en': 'ID-Palembang',
    'he': 'ID-פאלמבאנג',
    'ru': 'ID-Палембанг',
    'es': 'ID-Palembang',
    'eNameAndCode': 'ID-Palembang|1633070'
  },
  {
    'en': 'ID-Semarang',
    'he': 'ID-סמרנג',
    'ru': 'ID-Семаранг',
    'es': 'ID-Semarang',
    'eNameAndCode': 'ID-Semarang|1627896'
  },
  {
    'en': 'ID-South Tangerang',
    'he': "ID-דרום טנג'רנג",
    'ru': 'ID-Южный Тангеранг',
    'es': 'ID-Tangerang del Sur',
    'eNameAndCode': 'ID-South Tangerang|8581443'
  },
  {
    'en': 'ID-Surabaya',
    'he': 'ID-סורביה',
    'ru': 'ID-Сурабая',
    'es': 'ID-Surabaya',
    'eNameAndCode': 'ID-Surabaya|1625822'
  },
  {
    'en': 'ID-Tangerang',
    'he': "ID-טנג'רנג",
    'ru': 'ID-Тангеранг',
    'es': 'ID-Tangerang',
    'eNameAndCode': 'ID-Tangerang|1625084'
  },
  {
    'en': 'IE-Dublin',
    'he': 'IE-דבלין',
    'ru': 'IE-Дублин',
    'es': 'IE-Dublín',
    'eNameAndCode': 'IE-Dublin|2964574'
  },
  {
    'en': 'IL-Ashdod',
    'he': 'IL-אשדוד',
    'ru': 'IL-Ашдод',
    'es': 'IL-Asdod',
    'eNameAndCode': 'IL-Ashdod|295629'
  },
  {
    'en': 'IL-Ashkelon',
    'he': 'IL-אשקלון',
    'ru': 'IL-Ашкелон',
    'es': 'IL-Ascalón',
    'eNameAndCode': 'IL-Ashkelon|295620'
  },
  {
    'en': 'IL-Bat Yam',
    'he': 'IL-בת ים',
    'ru': 'IL-Бат-Ям',
    'es': 'IL-batata',
    'eNameAndCode': 'IL-Bat Yam|295548'
  },
  {
    'en': "IL-Be'er Sheva",
    'he': 'IL-באר שבע',
    'ru': 'IL-Беэр-Шева',
    'es': 'IL-Cerveza Sheva',
    'eNameAndCode': "IL-Be'er Sheva|295530"
  },
  {
    'en': 'IL-Beit Shemesh',
    'he': 'IL-בית שמש',
    'ru': 'IL-Бейт-Шемеш',
    'es': 'IL-Beit Shemesh',
    'eNameAndCode': 'IL-Beit Shemesh|295432'
  },
  {
    'en': 'IL-Bnei Brak',
    'he': 'IL-בני ברק',
    'ru': 'IL-Бней-Брак',
    'es': 'IL-Bnei Brak',
    'eNameAndCode': 'IL-Bnei Brak|295514'
  },
  {
    'en': 'IL-Eilat',
    'he': 'IL-אילת',
    'ru': 'IL-Эйлат',
    'es': 'IL-Eilat',
    'eNameAndCode': 'IL-Eilat|295277'
  },
  {
    'en': 'IL-Hadera',
    'he': 'IL-חדרה',
    'ru': 'IL-Хадера',
    'es': 'IL-Hadera',
    'eNameAndCode': 'IL-Hadera|294946'
  },
  {
    'en': 'IL-Haifa',
    'he': 'IL-חיפה',
    'ru': 'IL-Хайфа',
    'es': 'IL-haifa',
    'eNameAndCode': 'IL-Haifa|294801'
  },
  {
    'en': 'IL-Herzliya',
    'he': 'IL-הרצליה',
    'ru': 'IL-Герцлия',
    'es': 'IL-Herzliya',
    'eNameAndCode': 'IL-Herzliya|294778'
  },
  {
    'en': 'IL-Holon',
    'he': 'IL-חולון',
    'ru': 'IL-Холон',
    'es': 'IL-Holón',
    'eNameAndCode': 'IL-Holon|294751'
  },
  {
    'en': 'IL-Jerusalem',
    'he': 'IL-ירושלים',
    'ru': 'IL-Иерусалим',
    'es': 'IL-Jerusalén',
    'eNameAndCode': 'IL-Jerusalem|281184'
  },
  {
    'en': 'IL-Kfar Saba',
    'he': 'IL-כפר סבא',
    'ru': 'IL-Кфар-Саба',
    'es': 'IL-Kfar Saba',
    'eNameAndCode': 'IL-Kfar Saba|294514'
  },
  {
    'en': 'IL-Lod',
    'he': 'IL-לוד',
    'ru': 'IL-Лод',
    'es': 'IL-Lod',
    'eNameAndCode': 'IL-Lod|294421'
  },
  {
    'en': 'IL-Modiin',
    'he': 'IL-מודיעין',
    'ru': 'IL-Модиин',
    'es': 'IL-modificar',
    'eNameAndCode': 'IL-Modiin|282926'
  },
  {
    'en': 'IL-Nazareth',
    'he': 'IL-נצרת',
    'ru': 'IL-Назарет',
    'es': 'IL-Nazaret',
    'eNameAndCode': 'IL-Nazareth|294098'
  },
  {
    'en': 'IL-Netanya',
    'he': 'IL-נתניה',
    'ru': 'IL-Нетания',
    'es': 'IL-Netanya',
    'eNameAndCode': 'IL-Netanya|294071'
  },
  {
    'en': 'IL-Petach Tikvah',
    'he': 'IL-פתח תקווה',
    'ru': 'IL-Петах-Тиква',
    'es': 'IL-Petaj Tikva',
    'eNameAndCode': 'IL-Petach Tikvah|293918'
  },
  {
    'en': "IL-Ra'anana",
    'he': 'IL-רעננה',
    'ru': 'IL-Раанана',
    'es': 'IL-Raanana',
    'eNameAndCode': "IL-Ra'anana|293807"
  },
  {
    'en': 'IL-Ramat Gan',
    'he': 'IL-רמת גן',
    'ru': 'IL-Рамат-Ган',
    'es': 'IL-ramat gan',
    'eNameAndCode': 'IL-Ramat Gan|293788'
  },
  {
    'en': 'IL-Ramla',
    'he': 'IL-רמלה',
    'ru': 'IL-Рамла',
    'es': 'IL-Ramla',
    'eNameAndCode': 'IL-Ramla|293768'
  },
  {
    'en': 'IL-Rishon LeZion',
    'he': 'IL-ראשון לציון',
    'ru': 'IL-Ришон-ле-Цион',
    'es': 'IL-Rishon LeZion',
    'eNameAndCode': 'IL-Rishon LeZion|293703'
  },
  {
    'en': 'IL-Tel Aviv',
    'he': 'IL-תל אביב',
    'ru': 'IL-Тель-Авив',
    'es': 'IL-Tel Aviv',
    'eNameAndCode': 'IL-Tel Aviv|293397'
  },
  {
    'en': 'IL-Tiberias',
    'he': 'IL-טבריה',
    'ru': 'IL-Тверия',
    'es': 'IL-Tiberíades',
    'eNameAndCode': 'IL-Tiberias|293322'
  },
  {
    'en': 'IM-Douglas',
    'he': 'IM-דאגלס',
    'ru': 'IM-Дуглас',
    'es': 'IM-douglas',
    'eNameAndCode': 'IM-Douglas|3042237'
  },
  {
    'en': 'IN-Ahmadabad',
    'he': 'IN-אחמדאבאד',
    'ru': 'IN-Ахмедабад',
    'es': 'IN-Ahmedabad',
    'eNameAndCode': 'IN-Ahmadabad|1279233'
  },
  {
    'en': 'IN-Bangalore',
    'he': 'IN-בנגלור',
    'ru': 'IN-Бангалор',
    'es': 'IN-Bangalore',
    'eNameAndCode': 'IN-Bangalore|1277333'
  },
  {
    'en': 'IN-Bombay',
    'he': 'IN-בומביי',
    'ru': 'IN-Бомбей',
    'es': 'IN-Bombay',
    'eNameAndCode': 'IN-Bombay|1275339'
  },
  {
    'en': 'IN-Calcutta',
    'he': 'IN-כלכותה',
    'ru': 'IN-Калькутта',
    'es': 'IN-Calcuta',
    'eNameAndCode': 'IN-Calcutta|1275004'
  },
  {
    'en': 'IN-Chennai',
    'he': "IN-צ'נאי",
    'ru': 'IN-Ченнаи',
    'es': 'IN-Chennai',
    'eNameAndCode': 'IN-Chennai|1264527'
  },
  {
    'en': 'IN-Cochin',
    'he': "IN-קוצ'ין",
    'ru': 'IN-Кочин',
    'es': 'IN-Cochín',
    'eNameAndCode': 'IN-Cochin|1273874'
  },
  {
    'en': 'IN-Hyderabad',
    'he': 'IN-היידראבאד',
    'ru': 'IN-Хайдарабад',
    'es': 'IN-Hyderabad',
    'eNameAndCode': 'IN-Hyderabad|1269843'
  },
  {
    'en': 'IN-Jaipur',
    'he': "IN-ג'איפור",
    'ru': 'IN-Джайпур',
    'es': 'IN-Jaipur',
    'eNameAndCode': 'IN-Jaipur|1269515'
  },
  {
    'en': 'IN-Kanpur',
    'he': 'IN-קאנפור',
    'ru': 'IN-Канпур',
    'es': 'IN-Kanpur',
    'eNameAndCode': 'IN-Kanpur|1267995'
  },
  {
    'en': 'IN-New Delhi',
    'he': 'IN-ניו דלהי',
    'ru': 'IN-Нью-Дели',
    'es': 'IN-Nueva Delhi',
    'eNameAndCode': 'IN-New Delhi|1261481'
  },
  {
    'en': 'IN-Pune',
    'he': 'IN-פונה',
    'ru': 'IN-Пуна',
    'es': 'IN-Puno',
    'eNameAndCode': 'IN-Pune|1259229'
  },
  {
    'en': 'IN-Surat',
    'he': 'IN-סוראט',
    'ru': 'IN-Сурат',
    'es': 'IN-surat',
    'eNameAndCode': 'IN-Surat|1255364'
  },
  {
    'en': 'IQ-Baghdad',
    'he': 'IQ-בגדד',
    'ru': 'IQ-Багдад',
    'es': 'IQ-Bagdad',
    'eNameAndCode': 'IQ-Baghdad|98182'
  },
  {
    'en': 'IR-Tehran',
    'he': 'IR-טהראן',
    'ru': 'IR-Тегеран',
    'es': 'IR-Teherán',
    'eNameAndCode': 'IR-Tehran|112931'
  },
  {
    'en': 'IS-Reykjavík',
    'he': 'IS-רייקיאוויק',
    'ru': 'IS-Рейкьявик',
    'es': 'IS-Reikiavik',
    'eNameAndCode': 'IS-Reykjavík|3413829'
  },
  {
    'en': 'IT-Milano',
    'he': 'IT-מילאנו',
    'ru': 'IT-Милан',
    'es': 'IT-Milán',
    'eNameAndCode': 'IT-Milano|3173435'
  },
  {
    'en': 'IT-Rome',
    'he': 'IT-רומא',
    'ru': 'IT-Рим',
    'es': 'IT-Roma',
    'eNameAndCode': 'IT-Rome|3169070'
  },
  {
    'en': 'JM-Kingston',
    'he': 'JM-קינגסטון',
    'ru': 'JM-Кингстон',
    'es': 'JM-Kingston',
    'eNameAndCode': 'JM-Kingston|3489854'
  },
  {
    'en': 'JO-Amman',
    'he': 'JO-עמאן',
    'ru': 'JO-Амман',
    'es': 'JO-Amán',
    'eNameAndCode': 'JO-Amman|250441'
  },
  {
    'en': 'JP-Kobe-shi',
    'he': 'JP-קובי',
    'ru': 'JP-Кобе',
    'es': 'JP-Kobe',
    'eNameAndCode': 'JP-Kobe-shi|1859171'
  },
  {
    'en': 'JP-Kyoto',
    'he': 'JP-קיוטו',
    'ru': 'JP-Киото',
    'es': 'JP-Kioto',
    'eNameAndCode': 'JP-Kyoto|1857910'
  },
  {
    'en': 'JP-Nagoya-shi',
    'he': 'JP-נאגויה',
    'ru': 'JP-Нагоя',
    'es': 'JP-Nagoya',
    'eNameAndCode': 'JP-Nagoya-shi|1856057'
  },
  {
    'en': 'JP-Osaka-shi',
    'he': 'JP-אוסקה',
    'ru': 'JP-Осака',
    'es': 'JP-osaka',
    'eNameAndCode': 'JP-Osaka-shi|1853909'
  },
  {
    'en': 'JP-Sapporo',
    'he': 'JP-סאפורו',
    'ru': 'JP-Саппоро',
    'es': 'JP-Sapporo',
    'eNameAndCode': 'JP-Sapporo|2128295'
  },
  {
    'en': 'JP-Tokyo',
    'he': 'JP-טוקיו',
    'ru': 'JP-Токио',
    'es': 'JP-Tokio',
    'eNameAndCode': 'JP-Tokyo|1850147'
  },
  {
    'en': 'KE-Nairobi',
    'he': 'KE-ניירובי',
    'ru': 'KE-Найроби',
    'es': 'KE-Nairobi',
    'eNameAndCode': 'KE-Nairobi|184745'
  },
  {
    'en': 'KG-Bishkek',
    'he': 'KG-בישקק',
    'ru': 'KG-Бишкек',
    'es': 'KG-Biskek',
    'eNameAndCode': 'KG-Bishkek|1528675'
  },
  {
    'en': 'KH-Phnom Penh',
    'he': 'KH-פנום פן',
    'ru': 'KH-Пномпень',
    'es': 'KH-Phnom Penh',
    'eNameAndCode': 'KH-Phnom Penh|1821306'
  },
  {
    'en': 'KM-Moroni',
    'he': 'KM-מורוני',
    'ru': 'KM-Мороний',
    'es': 'KM-Moroni',
    'eNameAndCode': 'KM-Moroni|921772'
  },
  {
    'en': 'KN-Basseterre',
    'he': 'KN-באסטרה',
    'ru': 'KN-Бастер',
    'es': 'KN-Basseterre',
    'eNameAndCode': 'KN-Basseterre|3575551'
  },
  {
    'en': 'KP-Pyongyang',
    'he': 'KP-פיונגיאנג',
    'ru': 'KP-Пхеньян',
    'es': 'KP-Pionyang',
    'eNameAndCode': 'KP-Pyongyang|1871859'
  },
  {
    'en': 'KR-Busan',
    'he': 'KR-בוסאן',
    'ru': 'KR-Пусан',
    'es': 'KR-Busán',
    'eNameAndCode': 'KR-Busan|1838524'
  },
  {
    'en': 'KR-Seoul',
    'he': 'KR-סיאול',
    'ru': 'KR-Сеул',
    'es': 'KR-Seúl',
    'eNameAndCode': 'KR-Seoul|1835848'
  },
  {
    'en': 'KW-Kuwait',
    'he': 'KW-כווית',
    'ru': 'KW-Кувейт',
    'es': 'KW-Kuwait',
    'eNameAndCode': 'KW-Kuwait|285787'
  },
  {
    'en': 'KY-George Town',
    'he': "KY-ג'ורג' טאון",
    'ru': 'KY-Джорджтаун',
    'es': 'KY-ciudad de george',
    'eNameAndCode': 'KY-George Town|3580661'
  },
  {
    'en': 'KZ-Almaty',
    'he': 'KZ-אלמטי',
    'ru': 'KZ-Алматы',
    'es': 'KZ-Almatý',
    'eNameAndCode': 'KZ-Almaty|1526384'
  },
  {
    'en': 'KZ-Astana',
    'he': 'KZ-אסטנה',
    'ru': 'KZ-Астана',
    'es': 'KZ-Astaná',
    'eNameAndCode': 'KZ-Astana|1526273'
  },
  {
    'en': 'LA-Vientiane',
    'he': 'LA-ויינטיאן',
    'ru': 'LA-Вьентьян',
    'es': 'LA-Vientián',
    'eNameAndCode': 'LA-Vientiane|1651944'
  },
  {
    'en': 'LB-Beirut',
    'he': 'LB-ביירות',
    'ru': 'LB-Бейрут',
    'es': 'LB-Beirut',
    'eNameAndCode': 'LB-Beirut|276781'
  },
  {
    'en': 'LC-Castries',
    'he': 'LC-קסטריס',
    'ru': 'LC-Кастри',
    'es': 'LC-Castries',
    'eNameAndCode': 'LC-Castries|3576812'
  },
  {
    'en': 'LI-Vaduz',
    'he': 'LI-ואדוז',
    'ru': 'LI-Вадуц',
    'es': 'LI-Vaduz',
    'eNameAndCode': 'LI-Vaduz|3042030'
  },
  {
    'en': 'LR-Monrovia',
    'he': 'LR-מונרוביה',
    'ru': 'LR-Монровия',
    'es': 'LR-Monrovia',
    'eNameAndCode': 'LR-Monrovia|2274895'
  },
  {
    'en': 'LS-Maseru',
    'he': 'LS-מאסרו',
    'ru': 'LS-Масеру',
    'es': 'LS-Maseru',
    'eNameAndCode': 'LS-Maseru|932505'
  },
  {
    'en': 'LT-Vilnius',
    'he': 'LT-וילנה',
    'ru': 'LT-Вильнюс',
    'es': 'LT-Vilna',
    'eNameAndCode': 'LT-Vilnius|593116'
  },
  {
    'en': 'LU-Luxemburg',
    'he': 'LU-לוקסמבורג',
    'ru': 'LU-Люксембург',
    'es': 'LU-Luxemburgo',
    'eNameAndCode': 'LU-Luxemburg|2960316'
  },
  {
    'en': 'LV-Riga',
    'he': 'LV-ריגה',
    'ru': 'LV-Рига',
    'es': 'LV-riga',
    'eNameAndCode': 'LV-Riga|456172'
  },
  {
    'en': 'LY-Tripoli',
    'he': 'LY-טריפולי',
    'ru': 'LY-Триполи',
    'es': 'LY-Trípoli',
    'eNameAndCode': 'LY-Tripoli|2210247'
  },
  {
    'en': 'MA-Casablanca',
    'he': 'MA-קזבלנקה',
    'ru': 'MA-Касабланка',
    'es': 'MA-casablanca',
    'eNameAndCode': 'MA-Casablanca|2553604'
  },
  {
    'en': 'MA-Rabat',
    'he': 'MA-רבאט',
    'ru': 'MA-Рабат',
    'es': 'MA-Rabat',
    'eNameAndCode': 'MA-Rabat|2538475'
  },
  {
    'en': 'MD-Chisinau',
    'he': 'MD-קישינב',
    'ru': 'MD-Кишинев',
    'es': 'MD-Chisináu',
    'eNameAndCode': 'MD-Chisinau|618426'
  },
  {
    'en': 'ME-Podgorica',
    'he': 'ME-פודגוריצה',
    'ru': 'ME-Подгорица',
    'es': 'ME-Podgorica',
    'eNameAndCode': 'ME-Podgorica|3193044'
  },
  {
    'en': 'MG-Antananarivo',
    'he': 'MG-Antananarivo',
    'ru': 'MG-Антананариву',
    'es': 'MG-Antananarivo',
    'eNameAndCode': 'MG-Antananarivo|1070940'
  },
  {
    'en': 'MK-Skopje',
    'he': 'MK-סקופיה',
    'ru': 'MK-Скопье',
    'es': 'MK-Skopje',
    'eNameAndCode': 'MK-Skopje|785842'
  },
  {
    'en': 'ML-Bamako',
    'he': 'ML-במקו',
    'ru': 'ML-Бамако',
    'es': 'ML-bamako',
    'eNameAndCode': 'ML-Bamako|2460596'
  },
  {
    'en': 'MM-Mandalay',
    'he': 'MM-מנדליי',
    'ru': 'MM-Мандалай',
    'es': 'MM-Mandalay',
    'eNameAndCode': 'MM-Mandalay|1311874'
  },
  {
    'en': 'MM-Rangoon',
    'he': 'MM-רנגון',
    'ru': 'MM-Рангун',
    'es': 'MM-Rangún',
    'eNameAndCode': 'MM-Rangoon|1298824'
  },
  {
    'en': 'MN-Ulaanbaatar',
    'he': 'MN-אולן בטאר',
    'ru': 'MN-Улан-Батор',
    'es': 'MN-Ulán Bator',
    'eNameAndCode': 'MN-Ulaanbaatar|2028462'
  },
  {
    'en': 'MP-Saipan',
    'he': 'MP-סייפן',
    'ru': 'MP-Сайпан',
    'es': 'MP-Saipán',
    'eNameAndCode': 'MP-Saipan|7828758'
  },
  {
    'en': 'MR-Nouakchott',
    'he': 'MR-נואקשוט',
    'ru': 'MR-Нуакшот',
    'es': 'MR-Nuakchot',
    'eNameAndCode': 'MR-Nouakchott|2377450'
  },
  {
    'en': 'MS-Plymouth',
    'he': 'MS-פלימות',
    'ru': 'MS-Плимут',
    'es': 'MS-Plymouth',
    'eNameAndCode': 'MS-Plymouth|3578069'
  },
  {
    'en': 'MT-Valletta',
    'he': 'MT-ולטה',
    'ru': 'MT-Валлетта',
    'es': 'MT-La Valeta',
    'eNameAndCode': 'MT-Valletta|2562305'
  },
  {
    'en': 'MU-Port Louis',
    'he': 'MU-פורט לואיס',
    'ru': 'MU-Порт-Луи',
    'es': 'MU-puerto luis',
    'eNameAndCode': 'MU-Port Louis|934154'
  },
  {
    'en': 'MW-Lilongwe',
    'he': 'MW-לילונגווה',
    'ru': 'MW-Лилонгве',
    'es': 'MW-Lilongüe',
    'eNameAndCode': 'MW-Lilongwe|927967'
  },
  {
    'en': 'MX-Cancun',
    'he': 'MX-קנקון',
    'ru': 'MX-Канкун',
    'es': 'MX-Cancún',
    'eNameAndCode': 'MX-Cancun|3531673'
  },
  {
    'en': 'MX-Guadalajara',
    'he': 'MX-גוודלחרה',
    'ru': 'MX-Гвадалахара',
    'es': 'MX-guadalajara',
    'eNameAndCode': 'MX-Guadalajara|4005539'
  },
  {
    'en': 'MX-Iztapalapa',
    'he': 'MX-Iztapalapa',
    'ru': 'MX-Изтапалапа',
    'es': 'MX-Iztapalapa',
    'eNameAndCode': 'MX-Iztapalapa|3526683'
  },
  {
    'en': 'MX-Mazatlan',
    'he': 'MX-מזטלן',
    'ru': 'MX-Масатлан',
    'es': 'MX-Mazatlán',
    'eNameAndCode': 'MX-Mazatlan|3996322'
  },
  {
    'en': 'MX-Mexico City',
    'he': 'MX-העיר מקסיקו',
    'ru': 'MX-Мехико',
    'es': 'MX-Ciudad de México',
    'eNameAndCode': 'MX-Mexico City|3530597'
  },
  {
    'en': 'MX-Monterrey',
    'he': 'MX-מונטריי',
    'ru': 'MX-Монтеррей',
    'es': 'MX-monterrey',
    'eNameAndCode': 'MX-Monterrey|3995465'
  },
  {
    'en': 'MX-Puerto Vallarta',
    'he': 'MX-פוארטו ולארטה',
    'ru': 'MX-Пуэрто-Валларта',
    'es': 'MX-Puerto Vallarta',
    'eNameAndCode': 'MX-Puerto Vallarta|3991328'
  },
  {
    'en': 'MX-Tijuana',
    'he': 'MX-טיחואנה',
    'ru': 'MX-Тихуана',
    'es': 'MX-tijuana',
    'eNameAndCode': 'MX-Tijuana|3981609'
  },
  {
    'en': 'MY-Kota Bharu',
    'he': 'MY-קוטה בהארו',
    'ru': 'MY-Кота-Бару',
    'es': 'MY-Kota Bharu',
    'eNameAndCode': 'MY-Kota Bharu|1736376'
  },
  {
    'en': 'MY-Kuala Lumpur',
    'he': 'MY-קואלה לומפור',
    'ru': 'MY-Куала-Лумпур',
    'es': 'MY-Kuala Lumpur',
    'eNameAndCode': 'MY-Kuala Lumpur|1735161'
  },
  {
    'en': 'MZ-Maputo',
    'he': 'MZ-מאפוטו',
    'ru': 'MZ-Мапуту',
    'es': 'MZ-Maputo',
    'eNameAndCode': 'MZ-Maputo|1040652'
  },
  {
    'en': 'NA-Windhoek',
    'he': 'NA-וינדהוק',
    'ru': 'NA-Виндхук',
    'es': 'NA-Windhoek',
    'eNameAndCode': 'NA-Windhoek|3352136'
  },
  {
    'en': 'NC-Nouméa',
    'he': 'NC-נומיה',
    'ru': 'NC-Нумеа',
    'es': 'NC-Numea',
    'eNameAndCode': 'NC-Nouméa|2139521'
  },
  {
    'en': 'NE-Niamey',
    'he': 'NE-ניאמי',
    'ru': 'NE-Ниамей',
    'es': 'NE-Niamey',
    'eNameAndCode': 'NE-Niamey|2440485'
  },
  {
    'en': 'NG-Abuja',
    'he': "NG-אבוג'ה",
    'ru': 'NG-Абуджа',
    'es': 'NG-Abuya',
    'eNameAndCode': 'NG-Abuja|2352778'
  },
  {
    'en': 'NG-Lagos',
    'he': 'NG-לאגוס',
    'ru': 'NG-Лагос',
    'es': 'NG-Lagos',
    'eNameAndCode': 'NG-Lagos|2332459'
  },
  {
    'en': 'NI-Managua',
    'he': 'NI-מנגואה',
    'ru': 'NI-Манагуа',
    'es': 'NI-managua',
    'eNameAndCode': 'NI-Managua|3617763'
  },
  {
    'en': 'NL-Amsterdam',
    'he': 'NL-אמסטרדם',
    'ru': 'NL-Амстердам',
    'es': 'NL-Ámsterdam',
    'eNameAndCode': 'NL-Amsterdam|2759794'
  },
  {
    'en': 'NO-Oslo',
    'he': 'NO-אוסלו',
    'ru': 'NO-Осло',
    'es': 'NO-Oslo',
    'eNameAndCode': 'NO-Oslo|3143244'
  },
  {
    'en': 'NP-Kathmandu',
    'he': 'NP-קטמנדו',
    'ru': 'NP-Катманду',
    'es': 'NP-Katmandú',
    'eNameAndCode': 'NP-Kathmandu|1283240'
  },
  {
    'en': 'NU-Alofi',
    'he': 'NU-אלופי',
    'ru': 'NU-Алофи',
    'es': 'NU-alofi',
    'eNameAndCode': 'NU-Alofi|4036284'
  },
  {
    'en': 'NZ-Auckland',
    'he': 'NZ-אוקלנד',
    'ru': 'NZ-Окленд',
    'es': 'NZ-Auckland',
    'eNameAndCode': 'NZ-Auckland|2193733'
  },
  {
    'en': 'NZ-Christchurch',
    'he': "NZ-קרייסטצ'רץ",
    'ru': 'NZ-Крайстчерч',
    'es': 'NZ-christchurch',
    'eNameAndCode': 'NZ-Christchurch|2192362'
  },
  {
    'en': 'NZ-Wellington',
    'he': 'NZ-וולינגטון',
    'ru': 'NZ-Веллингтон',
    'es': 'NZ-Wellington',
    'eNameAndCode': 'NZ-Wellington|2179537'
  },
  {
    'en': 'OM-Muscat',
    'he': 'OM-מוּסקָט',
    'ru': 'OM-Мускат',
    'es': 'OM-Moscatel',
    'eNameAndCode': 'OM-Muscat|287286'
  },
  {
    'en': 'PA-Panama City',
    'he': 'PA-העיר פנמה',
    'ru': 'PA-Панама',
    'es': 'PA-ciudad de Panama',
    'eNameAndCode': 'PA-Panama City|3703443'
  },
  {
    'en': 'PE-Lima',
    'he': 'PE-לימה',
    'ru': 'PE-Лима',
    'es': 'PE-lima',
    'eNameAndCode': 'PE-Lima|3936456'
  },
  {
    'en': 'PF-Papeete',
    'he': 'PF-פאפיטה',
    'ru': 'PF-Папеэте',
    'es': 'PF-Papeete',
    'eNameAndCode': 'PF-Papeete|4033936'
  },
  {
    'en': 'PG-Port Moresby',
    'he': 'PG-פורט מורסבי',
    'ru': 'PG-Порт-Морсби',
    'es': 'PG-puerto moresby',
    'eNameAndCode': 'PG-Port Moresby|2088122'
  },
  {
    'en': 'PH-Manila',
    'he': 'PH-מנילה',
    'ru': 'PH-Манила',
    'es': 'PH-Manila',
    'eNameAndCode': 'PH-Manila|1701668'
  },
  {
    'en': 'PK-Islamabad',
    'he': 'PK-איסלמבאד',
    'ru': 'PK-Исламабад',
    'es': 'PK-islamabad',
    'eNameAndCode': 'PK-Islamabad|1176615'
  },
  {
    'en': 'PK-Karachi',
    'he': "PK-קראצ'י",
    'ru': 'PK-Карачи',
    'es': 'PK-Karachi',
    'eNameAndCode': 'PK-Karachi|1174872'
  },
  {
    'en': 'PL-Warsaw',
    'he': 'PL-ורשה',
    'ru': 'PL-Варшава',
    'es': 'PL-Varsovia',
    'eNameAndCode': 'PL-Warsaw|756135'
  },
  {
    'en': 'PR-San Juan',
    'he': 'PR-סן חואן',
    'ru': 'PR-Сан-Хуан',
    'es': 'PR-San Juan',
    'eNameAndCode': 'PR-San Juan|4568127'
  },
  {
    'en': 'PT-Lisbon',
    'he': 'PT-ליסבון',
    'ru': 'PT-Лиссабон',
    'es': 'PT-Lisboa',
    'eNameAndCode': 'PT-Lisbon|2267057'
  },
  {
    'en': 'PY-Asuncion',
    'he': 'PY-אסונסיון',
    'ru': 'PY-Асунсьон',
    'es': 'PY-Asunción',
    'eNameAndCode': 'PY-Asuncion|3439389'
  },
  {
    'en': 'QA-Doha',
    'he': 'QA-דוחה',
    'ru': 'QA-Доха',
    'es': 'QA-Doha',
    'eNameAndCode': 'QA-Doha|290030'
  },
  {
    'en': 'RO-Bucharest',
    'he': 'RO-בוקרשט',
    'ru': 'RO-Бухарест',
    'es': 'RO-Bucarest',
    'eNameAndCode': 'RO-Bucharest|683506'
  },
  {
    'en': 'RS-Belgrade',
    'he': 'RS-בלגרד',
    'ru': 'RS-Белград',
    'es': 'RS-Belgrado',
    'eNameAndCode': 'RS-Belgrade|792680'
  },
  {
    'en': 'RU-Moscow',
    'he': 'RU-מוסקבה',
    'ru': 'RU-Москва',
    'es': 'RU-Moscú',
    'eNameAndCode': 'RU-Moscow|524901'
  },
  {
    'en': 'RU-Novosibirsk',
    'he': 'RU-נובוסיבירסק',
    'ru': 'RU-Новосибирск',
    'es': 'RU-Novosibirsk',
    'eNameAndCode': 'RU-Novosibirsk|1496747'
  },
  {
    'en': 'RU-Saint Petersburg',
    'he': 'RU-סנט פטרסבורג',
    'ru': 'RU-Санкт-Петербург',
    'es': 'RU-San Petersburgo',
    'eNameAndCode': 'RU-Saint Petersburg|498817'
  },
  {
    'en': 'RU-Yekaterinburg',
    'he': 'RU-יקטרינבורג',
    'ru': 'RU-Екатеринбург',
    'es': 'RU-Ekaterimburgo',
    'eNameAndCode': 'RU-Yekaterinburg|1486209'
  },
  {
    'en': 'RW-Kigali',
    'he': 'RW-קיגאלי',
    'ru': 'RW-Кигали',
    'es': 'RW-Kigali',
    'eNameAndCode': 'RW-Kigali|202061'
  },
  {
    'en': 'SA-Jeddah',
    'he': "SA-ג'דה",
    'ru': 'SA-Джидда',
    'es': 'SA-Yeda',
    'eNameAndCode': 'SA-Jeddah|105343'
  },
  {
    'en': 'SA-Mecca',
    'he': 'SA-מכה',
    'ru': 'SA-Мекка',
    'es': 'SA-la meca',
    'eNameAndCode': 'SA-Mecca|104515'
  },
  {
    'en': 'SA-Medina',
    'he': 'SA-מדינה',
    'ru': 'SA-Медина',
    'es': 'SA-medina',
    'eNameAndCode': 'SA-Medina|109223'
  },
  {
    'en': 'SA-Riyadh',
    'he': 'SA-ריאד',
    'ru': 'SA-Эр-Рияд',
    'es': 'SA-Riad',
    'eNameAndCode': 'SA-Riyadh|108410'
  },
  {
    'en': 'SB-Honiara',
    'he': 'SB-הוניארה',
    'ru': 'SB-Хониара',
    'es': 'SB-Honiara',
    'eNameAndCode': 'SB-Honiara|2108502'
  },
  {
    'en': 'SC-Victoria',
    'he': 'SC-ויקטוריה',
    'ru': 'SC-Виктория',
    'es': 'SC-Victoria',
    'eNameAndCode': 'SC-Victoria|241131'
  },
  {
    'en': 'SD-Khartoum',
    'he': 'SD-חרטום',
    'ru': 'SD-Хартум',
    'es': 'SD-Jartum',
    'eNameAndCode': 'SD-Khartoum|379252'
  },
  {
    'en': 'SD-Omdurman',
    'he': 'SD-אומדורמן',
    'ru': 'SD-Омдурман',
    'es': 'SD-Omdurmán',
    'eNameAndCode': 'SD-Omdurman|365137'
  },
  {
    'en': 'SE-Stockholm',
    'he': 'SE-שטוקהולם',
    'ru': 'SE-Стокгольм',
    'es': 'SE-Estocolmo',
    'eNameAndCode': 'SE-Stockholm|2673730'
  },
  {
    'en': 'SG-Singapore',
    'he': 'SG-סינגפור',
    'ru': 'SG-Сингапур',
    'es': 'SG-Singapur',
    'eNameAndCode': 'SG-Singapore|1880252'
  },
  {
    'en': 'SH-Jamestown',
    'he': "SH-ג'יימסטאון",
    'ru': 'SH-Джеймстаун',
    'es': 'SH-jamestown',
    'eNameAndCode': 'SH-Jamestown|3370903'
  },
  {
    'en': 'SI-Ljubljana',
    'he': 'SI-לובליאנה',
    'ru': 'SI-Любляна',
    'es': 'SI-liubliana',
    'eNameAndCode': 'SI-Ljubljana|3196359'
  },
  {
    'en': 'SK-Bratislava',
    'he': 'SK-ברטיסלבה',
    'ru': 'SK-Братислава',
    'es': 'SK-Bratislava',
    'eNameAndCode': 'SK-Bratislava|3060972'
  },
  {
    'en': 'SL-Freetown',
    'he': 'SL-פריטאון',
    'ru': 'SL-Фритаун',
    'es': 'SL-ciudad libre',
    'eNameAndCode': 'SL-Freetown|2408770'
  },
  {
    'en': 'SN-Dakar',
    'he': 'SN-דקאר',
    'ru': 'SN-Дакар',
    'es': 'SN-Dakar',
    'eNameAndCode': 'SN-Dakar|2253354'
  },
  {
    'en': 'SO-Mogadishu',
    'he': 'SO-מוגדישו',
    'ru': 'SO-Могадишо',
    'es': 'SO-Mogadisio',
    'eNameAndCode': 'SO-Mogadishu|53654'
  },
  {
    'en': 'SR-Paramaribo',
    'he': 'SR-פרמריבו',
    'ru': 'SR-Парамарибо',
    'es': 'SR-Paramaribo',
    'eNameAndCode': 'SR-Paramaribo|3383330'
  },
  {
    'en': 'ST-São Tomé',
    'he': 'ST-סאו טומה',
    'ru': 'ST-Сан-Томе',
    'es': 'ST-Santo Tomé',
    'eNameAndCode': 'ST-São Tomé|2410763'
  },
  {
    'en': 'SV-San Salvador',
    'he': 'SV-סן סלבדור',
    'ru': 'SV-Сан-Сальвадор',
    'es': 'SV-San Salvador',
    'eNameAndCode': 'SV-San Salvador|3583361'
  },
  {
    'en': 'SY-Aleppo',
    'he': 'SY-חאלב',
    'ru': 'SY-Алеппо',
    'es': 'SY-Alepo',
    'eNameAndCode': 'SY-Aleppo|170063'
  },
  {
    'en': 'SY-Damascus',
    'he': 'SY-דמשק',
    'ru': 'SY-Дамаск',
    'es': 'SY-Damasco',
    'eNameAndCode': 'SY-Damascus|170654'
  },
  {
    'en': 'SZ-Mbabane',
    'he': 'SZ-אמבאפה',
    'ru': 'SZ-Мбабане',
    'es': 'SZ-Mbabane',
    'eNameAndCode': 'SZ-Mbabane|934985'
  },
  {
    'en': 'TC-Cockburn Town',
    'he': 'TC-קוקבורן טאון',
    'ru': 'TC-Кокберн Таун',
    'es': 'TC-ciudad de cockburn',
    'eNameAndCode': 'TC-Cockburn Town|3576994'
  },
  {
    'en': 'TD-Ndjamena',
    'he': "TD-נדג'מנה",
    'ru': 'TD-Нджамена',
    'es': 'TD-Ndjamena',
    'eNameAndCode': 'TD-Ndjamena|2427123'
  },
  {
    'en': 'TG-Lomé',
    'he': 'TG-לומה',
    'ru': 'TG-Ломе',
    'es': 'TG-Lomé',
    'eNameAndCode': 'TG-Lomé|2365267'
  },
  {
    'en': 'TH-Bangkok',
    'he': 'TH-בנגקוק',
    'ru': 'TH-Бангкок',
    'es': 'TH-bangkok',
    'eNameAndCode': 'TH-Bangkok|1609350'
  },
  {
    'en': 'TJ-Dushanbe',
    'he': 'TJ-דושנבה',
    'ru': 'TJ-Душанбе',
    'es': 'TJ-Dushanbe',
    'eNameAndCode': 'TJ-Dushanbe|1221874'
  },
  {
    'en': 'TM-Ashgabat',
    'he': 'TM-אשגבאט',
    'ru': 'TM-Ашхабад',
    'es': 'TM-Asjabad',
    'eNameAndCode': 'TM-Ashgabat|162183'
  },
  {
    'en': 'TN-Tunis',
    'he': 'TN-תוניס',
    'ru': 'TN-Тунис',
    'es': 'TN-Túnez',
    'eNameAndCode': 'TN-Tunis|2464470'
  },
  {
    'en': 'TR-Adana',
    'he': 'TR-עדנה',
    'ru': 'TR-Адана',
    'es': 'TR-Adana',
    'eNameAndCode': 'TR-Adana|325363'
  },
  {
    'en': 'TR-Ankara',
    'he': 'TR-אנקרה',
    'ru': 'TR-Анкара',
    'es': 'TR-Ankara',
    'eNameAndCode': 'TR-Ankara|323786'
  },
  {
    'en': 'TR-Bursa',
    'he': 'TR-אַמתָח',
    'ru': 'TR-Бурса',
    'es': 'TR-Bolsa',
    'eNameAndCode': 'TR-Bursa|750269'
  },
  {
    'en': 'TR-Istanbul',
    'he': 'TR-איסטנבול',
    'ru': 'TR-Стамбул',
    'es': 'TR-Estanbul',
    'eNameAndCode': 'TR-Istanbul|745044'
  },
  {
    'en': 'TR-Izmir',
    'he': 'TR-איזמיר',
    'ru': 'TR-Измир',
    'es': 'TR-Esmirna',
    'eNameAndCode': 'TR-Izmir|311046'
  },
  {
    'en': 'TV-Funafuti',
    'he': 'TV-Funafuti',
    'ru': 'TV-Фунафути',
    'es': 'TV-Funafuti',
    'eNameAndCode': 'TV-Funafuti|2110394'
  },
  {
    'en': 'TW-Kaohsiung',
    'he': 'TW-קאושיונג',
    'ru': 'TW-Гаосюн',
    'es': 'TW-Kaohsiung',
    'eNameAndCode': 'TW-Kaohsiung|1673820'
  },
  {
    'en': 'TW-Taipei',
    'he': 'TW-טייפה',
    'ru': 'TW-Тайбэй',
    'es': 'TW-Taipéi',
    'eNameAndCode': 'TW-Taipei|1668341'
  },
  {
    'en': 'TZ-Dar es Salaam',
    'he': 'TZ-דאר א-סלאם',
    'ru': 'TZ-Дар-эс-Салам',
    'es': 'TZ-Dar es Salaam',
    'eNameAndCode': 'TZ-Dar es Salaam|160263'
  },
  {
    'en': 'TZ-Dodoma',
    'he': 'TZ-דודומה',
    'ru': 'TZ-Додома',
    'es': 'TZ-Dodoma',
    'eNameAndCode': 'TZ-Dodoma|160196'
  },
  {
    'en': 'UA-Kharkiv',
    'he': 'UA-חרקוב',
    'ru': 'UA-Харьков',
    'es': 'UA-Járkov',
    'eNameAndCode': 'UA-Kharkiv|706483'
  },
  {
    'en': 'UA-Kiev',
    'he': 'UA-קייב',
    'ru': 'UA-Киев',
    'es': 'UA-kiev',
    'eNameAndCode': 'UA-Kiev|703448'
  },
  {
    'en': 'UG-Kampala',
    'he': 'UG-קמפלה',
    'ru': 'UG-Кампала',
    'es': 'UG-Kampala',
    'eNameAndCode': 'UG-Kampala|232422'
  },
  {
    'en': 'US-Atlanta-GA',
    'he': 'US-אטלנטה',
    'ru': 'US-Атланта',
    'es': 'US-atlanta',
    'eNameAndCode': 'US-Atlanta-GA|4180439'
  },
  {
    'en': 'US-Austin-TX',
    'he': 'US-אוסטין',
    'ru': 'US-Остин',
    'es': 'US-austin',
    'eNameAndCode': 'US-Austin-TX|4671654'
  },
  {
    'en': 'US-Baltimore-MD',
    'he': 'US-בולטימור',
    'ru': 'US-Балтимор',
    'es': 'US-baltimore',
    'eNameAndCode': 'US-Baltimore-MD|4347778'
  },
  {
    'en': 'US-Boston-MA',
    'he': 'US-בוסטון',
    'ru': 'US-Бостон',
    'es': 'US-Bostón',
    'eNameAndCode': 'US-Boston-MA|4930956'
  },
  {
    'en': 'US-Buffalo-NY',
    'he': 'US-תְאוֹ',
    'ru': 'US-Баффало',
    'es': 'US-Búfalo',
    'eNameAndCode': 'US-Buffalo-NY|5110629'
  },
  {
    'en': 'US-Chicago-IL',
    'he': 'US-שיקגו',
    'ru': 'US-Чикаго',
    'es': 'US-chicago',
    'eNameAndCode': 'US-Chicago-IL|4887398'
  },
  {
    'en': 'US-Cincinnati-OH',
    'he': 'US-סינסינטי',
    'ru': 'US-Цинциннати',
    'es': 'US-Cincinnati',
    'eNameAndCode': 'US-Cincinnati-OH|4508722'
  },
  {
    'en': 'US-Cleveland-OH',
    'he': 'US-קליבלנד',
    'ru': 'US-Кливленд',
    'es': 'US-cleveland',
    'eNameAndCode': 'US-Cleveland-OH|5150529'
  },
  {
    'en': 'US-Columbus-OH',
    'he': 'US-קולומבוס',
    'ru': 'US-Колумбус',
    'es': 'US-Colón',
    'eNameAndCode': 'US-Columbus-OH|4509177'
  },
  {
    'en': 'US-Dallas-TX',
    'he': 'US-דאלאס',
    'ru': 'US-Даллас',
    'es': 'US-dallas',
    'eNameAndCode': 'US-Dallas-TX|4684888'
  },
  {
    'en': 'US-Denver-CO',
    'he': 'US-דנבר',
    'ru': 'US-Денвер',
    'es': 'US-denver',
    'eNameAndCode': 'US-Denver-CO|5419384'
  },
  {
    'en': 'US-Detroit-MI',
    'he': 'US-דטרויט',
    'ru': 'US-Детройт',
    'es': 'US-detroit',
    'eNameAndCode': 'US-Detroit-MI|4990729'
  },
  {
    'en': 'US-Hartford-CT',
    'he': 'US-הרטפורד',
    'ru': 'US-Хартфорд',
    'es': 'US-Hartford',
    'eNameAndCode': 'US-Hartford-CT|4835797'
  },
  {
    'en': 'US-Honolulu-HI',
    'he': 'US-הונולולו',
    'ru': 'US-Гонолулу',
    'es': 'US-Honolulú',
    'eNameAndCode': 'US-Honolulu-HI|5856195'
  },
  {
    'en': 'US-Houston-TX',
    'he': 'US-יוסטון',
    'ru': 'US-Хьюстон',
    'es': 'US-houston',
    'eNameAndCode': 'US-Houston-TX|4699066'
  },
  {
    'en': 'US-Lakewood-NJ',
    'he': 'US-לייקווד',
    'ru': 'US-Лейквуд',
    'es': 'US-Lakewood',
    'eNameAndCode': 'US-Lakewood-NJ|5100280'
  },
  {
    'en': 'US-Las Vegas-NV',
    'he': 'US-לאס וגאס',
    'ru': 'US-Лас Вегас',
    'es': 'US-Las Vegas',
    'eNameAndCode': 'US-Las Vegas-NV|5506956'
  },
  {
    'en': 'US-Livingston-NY',
    'he': 'US-ליווינגסטון',
    'ru': 'US-Ливингстон',
    'es': 'US-Lívingston',
    'eNameAndCode': 'US-Livingston-NY|5100572'
  },
  {
    'en': 'US-Los Angeles-CA',
    'he': "US-לוס אנג'לס",
    'ru': 'US-Лос-Анджелес',
    'es': 'US-los Angeles',
    'eNameAndCode': 'US-Los Angeles-CA|5368361'
  },
  {
    'en': 'US-Memphis-TN',
    'he': 'US-ממפיס',
    'ru': 'US-Мемфис',
    'es': 'US-Menfis',
    'eNameAndCode': 'US-Memphis-TN|4641239'
  },
  {
    'en': 'US-Miami-FL',
    'he': 'US-מיאמי',
    'ru': 'US-Майами',
    'es': 'US-miami',
    'eNameAndCode': 'US-Miami-FL|4164138'
  },
  {
    'en': 'US-Milwaukee-WI',
    'he': 'US-מילווקי',
    'ru': 'US-Милуоки',
    'es': 'US-milwaukee',
    'eNameAndCode': 'US-Milwaukee-WI|5263045'
  },
  {
    'en': 'US-Monsey-NY',
    'he': 'US-מונסי',
    'ru': 'US-Монси',
    'es': 'US-Monsey',
    'eNameAndCode': 'US-Monsey-NY|5127315'
  },
  {
    'en': 'US-New Haven-CT',
    'he': 'US-גן עדן חדש',
    'ru': 'US-Новый рай',
    'es': 'US-nuevo refugio',
    'eNameAndCode': 'US-New Haven-CT|4839366'
  },
  {
    'en': 'US-New York-NY',
    'he': 'US-ניו יורק',
    'ru': 'US-Нью-Йорк',
    'es': 'US-Nueva York',
    'eNameAndCode': 'US-New York-NY|5128581'
  },
  {
    'en': 'US-Omaha-NE',
    'he': 'US-אומהה',
    'ru': 'US-Омаха',
    'es': 'US-Omaha',
    'eNameAndCode': 'US-Omaha-NE|5074472'
  },
  {
    'en': 'US-Orlando-FL',
    'he': 'US-אורלנדו',
    'ru': 'US-Орландо',
    'es': 'US-orlando',
    'eNameAndCode': 'US-Orlando-FL|4167147'
  },
  {
    'en': 'US-Passaic-NJ',
    'he': 'US-פסאיץ',
    'ru': 'US-Пассаик',
    'es': 'US-Passaic',
    'eNameAndCode': 'US-Passaic-NJ|5102443'
  },
  {
    'en': 'US-Philadelphia-PA',
    'he': 'US-פילדלפיה',
    'ru': 'US-Филадельфия',
    'es': 'US-Filadelfia',
    'eNameAndCode': 'US-Philadelphia-PA|4560349'
  },
  {
    'en': 'US-Phoenix-AZ',
    'he': 'US-פניקס',
    'ru': 'US-Феникс',
    'es': 'US-Fénix',
    'eNameAndCode': 'US-Phoenix-AZ|5308655'
  },
  {
    'en': 'US-Pittsburgh-PA',
    'he': 'US-פיטסבורג',
    'ru': 'US-Питтсбург',
    'es': 'US-pittsburgh',
    'eNameAndCode': 'US-Pittsburgh-PA|5206379'
  },
  {
    'en': 'US-Portland-OR',
    'he': 'US-פורטלנד',
    'ru': 'US-Портленд',
    'es': 'US-Pórtland',
    'eNameAndCode': 'US-Portland-OR|5746545'
  },
  {
    'en': 'US-Providence-RI',
    'he': 'US-הַשׁגָחָה עֶליוֹנָה',
    'ru': 'US-Провиденс',
    'es': 'US-Providencia',
    'eNameAndCode': 'US-Providence-RI|5224151'
  },
  {
    'en': 'US-Richmond-VA',
    'he': "US-ריצ'מונד",
    'ru': 'US-Ричмонд',
    'es': 'US-richmond',
    'eNameAndCode': 'US-Richmond-VA|4781708'
  },
  {
    'en': 'US-Rochester-NY',
    'he': "US-רוצ'סטר",
    'ru': 'US-Рочестер',
    'es': 'US-Rochester',
    'eNameAndCode': 'US-Rochester-NY|5134086'
  },
  {
    'en': 'US-Saint Louis-MO',
    'he': 'US-סנט לואיס',
    'ru': 'US-Сент-Луис',
    'es': 'US-San Luis',
    'eNameAndCode': 'US-Saint Louis-MO|4407066'
  },
  {
    'en': 'US-Saint Paul-MN',
    'he': 'US-סנט פול',
    'ru': 'US-Святой Павел',
    'es': 'US-San Pablo',
    'eNameAndCode': 'US-Saint Paul-MN|5045360'
  },
  {
    'en': 'US-San Diego-CA',
    'he': 'US-סן דייגו',
    'ru': 'US-Сан Диего',
    'es': 'US-San Diego',
    'eNameAndCode': 'US-San Diego-CA|5391811'
  },
  {
    'en': 'US-San Francisco-CA',
    'he': 'US-סן פרנסיסקו',
    'ru': 'US-Сан-Франциско',
    'es': 'US-San Francisco',
    'eNameAndCode': 'US-San Francisco-CA|5391959'
  },
  {
    'en': 'US-Seattle-WA',
    'he': 'US-סיאטל',
    'ru': 'US-Сиэтл',
    'es': 'US-Seattle',
    'eNameAndCode': 'US-Seattle-WA|5809844'
  },
  {
    'en': 'US-Silver Spring-MD',
    'he': 'US-סילבר אביב',
    'ru': 'US-Серебряная весна',
    'es': 'US-Primavera plateada',
    'eNameAndCode': 'US-Silver Spring-MD|4369596'
  },
  {
    'en': 'US-Teaneck-NJ',
    'he': 'US-Teaneck',
    'ru': 'US-Тинек',
    'es': 'US-cuello de té',
    'eNameAndCode': 'US-Teaneck-NJ|5105262'
  },
  {
    'en': 'US-Washington-DC',
    'he': 'US-וושינגטון',
    'ru': 'US-Вашингтон',
    'es': 'US-Washington',
    'eNameAndCode': 'US-Washington-DC|4140963'
  },
  {
    'en': 'US-White Plains-NY',
    'he': 'US-White Plains',
    'ru': 'US-Белые равнины',
    'es': 'US-llanuras blancas',
    'eNameAndCode': 'US-White Plains-NY|5144336'
  },
  {
    'en': 'UY-Montevideo',
    'he': 'UY-מונטווידאו',
    'ru': 'UY-Монтевидео',
    'es': 'UY-Montevideo',
    'eNameAndCode': 'UY-Montevideo|3441575'
  },
  {
    'en': 'UZ-Tashkent',
    'he': 'UZ-טשקנט',
    'ru': 'UZ-Ташкент',
    'es': 'UZ-Tashkent',
    'eNameAndCode': 'UZ-Tashkent|1512569'
  },
  {
    'en': 'VC-Kingstown',
    'he': 'VC-קינגסטאון',
    'ru': 'VC-Кингстаун',
    'es': 'VC-Kingstown',
    'eNameAndCode': 'VC-Kingstown|3577887'
  },
  {
    'en': 'VE-Caracas',
    'he': 'VE-קראקס',
    'ru': 'VE-Каракас',
    'es': 'VE-Caracas',
    'eNameAndCode': 'VE-Caracas|3646738'
  },
  {
    'en': 'VE-Maracaibo',
    'he': 'VE-Maracaibo',
    'ru': 'VE-Маракайбо',
    'es': 'VE-Maracaibo',
    'eNameAndCode': 'VE-Maracaibo|3633009'
  },
  {
    'en': 'VE-Maracay',
    'he': 'VE-מראקאי',
    'ru': 'VE-Маракай',
    'es': 'VE-Maracay',
    'eNameAndCode': 'VE-Maracay|3632998'
  },
  {
    'en': 'VE-Valencia',
    'he': 'VE-ולנסיה',
    'ru': 'VE-Валенсия',
    'es': 'VE-Valencia',
    'eNameAndCode': 'VE-Valencia|3625549'
  },
  {
    'en': 'VG-Road Town',
    'he': 'VG-Road Town',
    'ru': 'VG-Роад Таун',
    'es': 'VG-Ciudad del camino',
    'eNameAndCode': 'VG-Road Town|3577430'
  },
  {
    'en': 'VN-Hanoi',
    'he': 'VN-האנוי',
    'ru': 'VN-Ханой',
    'es': 'VN-Hanoi',
    'eNameAndCode': 'VN-Hanoi|1581130'
  },
  {
    'en': 'VN-Ho Chi Minh City',
    'he': "VN-הו צ'י מין סיטי",
    'ru': 'VN-Хошимин',
    'es': 'VN-Ciudad de Ho Chi Minh',
    'eNameAndCode': 'VN-Ho Chi Minh City|1566083'
  },
  {
    'en': 'WS-Apia',
    'he': 'WS-אפיה',
    'ru': 'WS-Апиа',
    'es': 'WS-Apia',
    'eNameAndCode': 'WS-Apia|4035413'
  },
  {
    'en': 'YE-Sanaa',
    'he': 'YE-צנעא',
    'ru': 'YE-Сана',
    'es': 'YE-Saná',
    'eNameAndCode': 'YE-Sanaa|71137'
  },
  {
    'en': 'YT-Mamoudzou',
    'he': 'YT-מאמודזו',
    'ru': 'YT-Мамудзу',
    'es': 'YT-Mamoudzou',
    'eNameAndCode': 'YT-Mamoudzou|921815'
  },
  {
    'en': 'ZA-Cape Town',
    'he': 'ZA-קייפטאון',
    'ru': 'ZA-Кейптаун',
    'es': 'ZA-ciudad del cabo',
    'eNameAndCode': 'ZA-Cape Town|3369157'
  },
  {
    'en': 'ZA-Durban',
    'he': 'ZA-דרבן',
    'ru': 'ZA-Дурбан',
    'es': 'ZA-Durban',
    'eNameAndCode': 'ZA-Durban|1007311'
  },
  {
    'en': 'ZA-Johannesburg',
    'he': 'ZA-יוהנסבורג',
    'ru': 'ZA-Йоханнесбург',
    'es': 'ZA-Johannesburgo',
    'eNameAndCode': 'ZA-Johannesburg|993800'
  },
  {
    'en': 'ZA-Pretoria',
    'he': 'ZA-פרטוריה',
    'ru': 'ZA-Претория',
    'es': 'ZA-Pretoria',
    'eNameAndCode': 'ZA-Pretoria|964137'
  },
  {
    'en': 'ZM-Lusaka',
    'he': 'ZM-לוסקה',
    'ru': 'ZM-Лусака',
    'es': 'ZM-Lusaka',
    'eNameAndCode': 'ZM-Lusaka|909137'
  },
  {
    'en': 'ZW-Harare',
    'he': 'ZW-הרארה',
    'ru': 'ZW-Хараре',
    'es': 'ZW-Harare',
    'eNameAndCode': 'ZW-Harare|890299'
  }
];

const eCitiesAndCode = [
  'AD-Andorra La Vella|3041563',
  'AE-Abu Dhabi|292968',
  'AE-Dubai|292223',
  'AF-Kabul|1138958',
  'AI-The Valley|3573374',
  'AL-Tirana|3183875',
  'AM-Yerevan|616052',
  'AO-Luanda|2240449',
  'AR-Buenos Aires|3435910',
  'AR-Cordoba|3860259',
  'AR-Rosario|3838583',
  'AS-Pago Pago|5881576',
  'AT-Vienna|2761369',
  'AU-Adelaide|2078025',
  'AU-Brisbane|2174003',
  'AU-Canberra|2172517',
  'AU-Gold Coast|2165087',
  'AU-Hobart|2163355',
  'AU-Melbourne|2158177',
  'AU-Perth|2063523',
  'AU-Sydney|2147714',
  'AW-Oranjestad|3577154',
  'AZ-Baku|587084',
  'BA-Sarajevo|3191281',
  'BB-Bridgetown|3374036',
  'BD-Chittagong|1205733',
  'BD-Dhaka|1185241',
  'BD-Khulna|1336135',
  'BE-Brussels|2800866',
  'BF-Ouagadougou|2357048',
  'BG-Sofia|727011',
  'BH-Manama|290340',
  'BI-Bujumbura|425378',
  'BJ-Porto-novo|2392087',
  'BM-Hamilton|3573197',
  'BN-Bandar Seri Begawan|1820906',
  'BO-La Paz|3911925',
  'BO-Santa Cruz de la Sierra|3904906',
  'BR-Belo Horizonte|3470127',
  'BR-Brasilia|3469058',
  'BR-Fortaleza|3399415',
  'BR-Rio de Janeiro|3451190',
  'BR-Salvador|3450554',
  'BR-Sao Paulo|3448439',
  'BS-Nassau|3571824',
  'BT-Thimphu|1252416',
  'BW-Gaborone|933773',
  'BY-Minsk|625144',
  'BZ-Belmopan|3582672',
  'CA-Calgary|5913490',
  'CA-Edmonton|5946768',
  'CA-Halifax|6324729',
  'CA-Mississauga|6075357',
  'CA-Montreal|6077243',
  'CA-Ottawa|6094817',
  'CA-Quebec City|6325494',
  'CA-Regina|6119109',
  'CA-Saskatoon|6141256',
  'CA-St. John\'s-05|6324733',
  'CA-Toronto|6167865',
  'CA-Vancouver|6173331',
  'CA-Victoria|6174041',
  'CA-Winnipeg|6183235',
  'CD-Kinshasa|2314302',
  'CD-Lubumbashi|922704',
  'CF-Bangui|2389853',
  'CG-Brazzaville|2260535',
  'CH-Bern|2661552',
  'CH-Geneva|2660646',
  'CH-Zurich|2657896',
  'CI-Abidjan|2293538',
  'CI-Yamoussoukro|2279755',
  'CK-Avarua|4035715',
  'CL-Santiago|3871336',
  'CM-Douala|2232593',
  'CM-Yaounde|2220957',
  'CN-Beijing|1816670',
  'CN-Chengdu|1815286',
  'CN-Chongqing|1814906',
  'CN-Guangzhou|1809858',
  'CN-Harbin|2037013',
  'CN-Kaifeng|1804879',
  'CN-Lanzhou|1804430',
  'CN-Nanchong|1800146',
  'CN-Nanjing|1799962',
  'CN-Puyang|1798422',
  'CN-Shanghai|1796236',
  'CN-Shenyang|2034937',
  'CN-Shenzhen|1795565',
  'CN-Shiyan|1794903',
  'CN-Tai\'an|1793724',
  'CN-Tianjin|1792947',
  'CN-Wuhan|1791247',
  'CN-Xi\'an|1790630',
  'CN-Yueyang|1927639',
  'CN-Zhumadian|1783873',
  'CO-Barranquilla|3689147',
  'CO-Bogota|3688689',
  'CO-Cali|3687925',
  'CO-Medellin|3674962',
  'CR-San José|3621849',
  'CU-Havana|3553478',
  'CV-Praia|3374333',
  'CW-Willemstad|3513090',
  'CY-Nicosia|146268',
  'CZ-Prague|3067696',
  'DE-Berlin|2950159',
  'DE-Hamburg|2911298',
  'DE-Munich|2867714',
  'DK-Copenhagen|2618425',
  'DM-Roseau|3575635',
  'DO-Santiago de los Caballeros|3492914',
  'DO-Santo Domingo|3492908',
  'DZ-Algiers|2507480',
  'EC-Guayaquil|3657509',
  'EC-Quito|3652462',
  'EE-Tallinn|588409',
  'EG-Al Jizah|360995',
  'EG-Alexandria|361058',
  'EG-Cairo|360630',
  'ER-Asmara|343300',
  'ES-Barcelona|3128760',
  'ES-Madrid|3117735',
  'ET-Addis Ababa|344979',
  'FI-Helsinki|658225',
  'FJ-Suva|2198148',
  'FK-Stanley|3426691',
  'FO-Tórshavn|2611396',
  'FR-Marseilles|2995469',
  'FR-Paris|2988507',
  'GA-Libreville|2399697',
  'GB-Belfast|2655984',
  'GB-Birmingham|2655603',
  'GB-Bristol|2654675',
  'GB-Cardiff|2653822',
  'GB-Edinburgh|2650225',
  'GB-Glasgow|2648579',
  'GB-Leeds|2644688',
  'GB-Liverpool|2644210',
  'GB-London|2643743',
  'GB-Manchester|2643123',
  'GB-Sheffield|2638077',
  'GE-Tbilisi|611717',
  'GH-Accra|2306104',
  'GH-Kumasi|2298890',
  'GI-Gibraltar|2411585',
  'GL-Nuuk|3421319',
  'GM-Banjul|2413876',
  'GN-Camayenne|2422488',
  'GN-Conakry|2422465',
  'GQ-Malabo|2309527',
  'GR-Athens|264371',
  'GT-Guatemala City|3598132',
  'GW-Bissau|2374775',
  'GY-Georgetown|3378644',
  'HK-Hong Kong|1819729',
  'HN-Tegucigalpa|3600949',
  'HR-Zagreb|3186886',
  'HT-Port-au-Prince|3718426',
  'HU-Budapest|3054643',
  'ID-Bandung|1650357',
  'ID-Bekasi|1649378',
  'ID-Depok|1645518',
  'ID-Jakarta|1642911',
  'ID-Makassar|1622786',
  'ID-Medan|1214520',
  'ID-Palembang|1633070',
  'ID-Semarang|1627896',
  'ID-South Tangerang|8581443',
  'ID-Surabaya|1625822',
  'ID-Tangerang|1625084',
  'IE-Dublin|2964574',
  'IL-Ashdod|295629',
  'IL-Ashkelon|295620',
  'IL-Bat Yam|295548',
  'IL-Be\'er Sheva|295530',
  'IL-Beit Shemesh|295432',
  'IL-Bnei Brak|295514',
  'IL-Eilat|295277',
  'IL-Hadera|294946',
  'IL-Haifa|294801',
  'IL-Herzliya|294778',
  'IL-Holon|294751',
  'IL-Jerusalem|281184',
  'IL-Kfar Saba|294514',
  'IL-Lod|294421',
  'IL-Modiin|282926',
  'IL-Nazareth|294098',
  'IL-Netanya|294071',
  'IL-Petach Tikvah|293918',
  'IL-Ra\'anana|293807',
  'IL-Ramat Gan|293788',
  'IL-Ramla|293768',
  'IL-Rishon LeZion|293703',
  'IL-Tel Aviv|293397',
  'IL-Tiberias|293322',
  'IM-Douglas|3042237',
  'IN-Ahmadabad|1279233',
  'IN-Bangalore|1277333',
  'IN-Bombay|1275339',
  'IN-Calcutta|1275004',
  'IN-Chennai|1264527',
  'IN-Cochin|1273874',
  'IN-Hyderabad|1269843',
  'IN-Jaipur|1269515',
  'IN-Kanpur|1267995',
  'IN-New Delhi|1261481',
  'IN-Pune|1259229',
  'IN-Surat|1255364',
  'IQ-Baghdad|98182',
  'IR-Tehran|112931',
  'IS-Reykjavík|3413829',
  'IT-Milano|3173435',
  'IT-Rome|3169070',
  'JM-Kingston|3489854',
  'JO-Amman|250441',
  'JP-Kobe-shi|1859171',
  'JP-Kyoto|1857910',
  'JP-Nagoya-shi|1856057',
  'JP-Osaka-shi|1853909',
  'JP-Sapporo|2128295',
  'JP-Tokyo|1850147',
  'KE-Nairobi|184745',
  'KG-Bishkek|1528675',
  'KH-Phnom Penh|1821306',
  'KM-Moroni|921772',
  'KN-Basseterre|3575551',
  'KP-Pyongyang|1871859',
  'KR-Busan|1838524',
  'KR-Seoul|1835848',
  'KW-Kuwait|285787',
  'KY-George Town|3580661',
  'KZ-Almaty|1526384',
  'KZ-Astana|1526273',
  'LA-Vientiane|1651944',
  'LB-Beirut|276781',
  'LC-Castries|3576812',
  'LI-Vaduz|3042030',
  'LR-Monrovia|2274895',
  'LS-Maseru|932505',
  'LT-Vilnius|593116',
  'LU-Luxemburg|2960316',
  'LV-Riga|456172',
  'LY-Tripoli|2210247',
  'MA-Casablanca|2553604',
  'MA-Rabat|2538475',
  'MD-Chisinau|618426',
  'ME-Podgorica|3193044',
  'MG-Antananarivo|1070940',
  'MK-Skopje|785842',
  'ML-Bamako|2460596',
  'MM-Mandalay|1311874',
  'MM-Rangoon|1298824',
  'MN-Ulaanbaatar|2028462',
  'MP-Saipan|7828758',
  'MR-Nouakchott|2377450',
  'MS-Plymouth|3578069',
  'MT-Valletta|2562305',
  'MU-Port Louis|934154',
  'MW-Lilongwe|927967',
  'MX-Cancun|3531673',
  'MX-Guadalajara|4005539',
  'MX-Iztapalapa|3526683',
  'MX-Mazatlan|3996322',
  'MX-Mexico City|3530597',
  'MX-Monterrey|3995465',
  'MX-Puerto Vallarta|3991328',
  'MX-Tijuana|3981609',
  'MY-Kota Bharu|1736376',
  'MY-Kuala Lumpur|1735161',
  'MZ-Maputo|1040652',
  'NA-Windhoek|3352136',
  'NC-Nouméa|2139521',
  'NE-Niamey|2440485',
  'NG-Abuja|2352778',
  'NG-Lagos|2332459',
  'NI-Managua|3617763',
  'NL-Amsterdam|2759794',
  'NO-Oslo|3143244',
  'NP-Kathmandu|1283240',
  'NU-Alofi|4036284',
  'NZ-Auckland|2193733',
  'NZ-Christchurch|2192362',
  'NZ-Wellington|2179537',
  'OM-Muscat|287286',
  'PA-Panama City|3703443',
  'PE-Lima|3936456',
  'PF-Papeete|4033936',
  'PG-Port Moresby|2088122',
  'PH-Manila|1701668',
  'PK-Islamabad|1176615',
  'PK-Karachi|1174872',
  'PL-Warsaw|756135',
  'PR-San Juan|4568127',
  'PT-Lisbon|2267057',
  'PY-Asuncion|3439389',
  'QA-Doha|290030',
  'RO-Bucharest|683506',
  'RS-Belgrade|792680',
  'RU-Moscow|524901',
  'RU-Novosibirsk|1496747',
  'RU-Saint Petersburg|498817',
  'RU-Yekaterinburg|1486209',
  'RW-Kigali|202061',
  'SA-Jeddah|105343',
  'SA-Mecca|104515',
  'SA-Medina|109223',
  'SA-Riyadh|108410',
  'SB-Honiara|2108502',
  'SC-Victoria|241131',
  'SD-Khartoum|379252',
  'SD-Omdurman|365137',
  'SE-Stockholm|2673730',
  'SG-Singapore|1880252',
  'SH-Jamestown|3370903',
  'SI-Ljubljana|3196359',
  'SK-Bratislava|3060972',
  'SL-Freetown|2408770',
  'SN-Dakar|2253354',
  'SO-Mogadishu|53654',
  'SR-Paramaribo|3383330',
  'ST-São Tomé|2410763',
  'SV-San Salvador|3583361',
  'SY-Aleppo|170063',
  'SY-Damascus|170654',
  'SZ-Mbabane|934985',
  'TC-Cockburn Town|3576994',
  'TD-Ndjamena|2427123',
  'TG-Lomé|2365267',
  'TH-Bangkok|1609350',
  'TJ-Dushanbe|1221874',
  'TM-Ashgabat|162183',
  'TN-Tunis|2464470',
  'TR-Adana|325363',
  'TR-Ankara|323786',
  'TR-Bursa|750269',
  'TR-Istanbul|745044',
  'TR-Izmir|311046',
  'TV-Funafuti|2110394',
  'TW-Kaohsiung|1673820',
  'TW-Taipei|1668341',
  'TZ-Dar es Salaam|160263',
  'TZ-Dodoma|160196',
  'UA-Kharkiv|706483',
  'UA-Kiev|703448',
  'UG-Kampala|232422',
  'US-Atlanta-GA|4180439',
  'US-Austin-TX|4671654',
  'US-Baltimore-MD|4347778',
  'US-Boston-MA|4930956',
  'US-Buffalo-NY|5110629',
  'US-Chicago-IL|4887398',
  'US-Cincinnati-OH|4508722',
  'US-Cleveland-OH|5150529',
  'US-Columbus-OH|4509177',
  'US-Dallas-TX|4684888',
  'US-Denver-CO|5419384',
  'US-Detroit-MI|4990729',
  'US-Hartford-CT|4835797',
  'US-Honolulu-HI|5856195',
  'US-Houston-TX|4699066',
  'US-Lakewood-NJ|5100280',
  'US-Las Vegas-NV|5506956',
  'US-Livingston-NY|5100572',
  'US-Los Angeles-CA|5368361',
  'US-Memphis-TN|4641239',
  'US-Miami-FL|4164138',
  'US-Milwaukee-WI|5263045',
  'US-Monsey-NY|5127315',
  'US-New Haven-CT|4839366',
  'US-New York-NY|5128581',
  'US-Omaha-NE|5074472',
  'US-Orlando-FL|4167147',
  'US-Passaic-NJ|5102443',
  'US-Philadelphia-PA|4560349',
  'US-Phoenix-AZ|5308655',
  'US-Pittsburgh-PA|5206379',
  'US-Portland-OR|5746545',
  'US-Providence-RI|5224151',
  'US-Richmond-VA|4781708',
  'US-Rochester-NY|5134086',
  'US-Saint Louis-MO|4407066',
  'US-Saint Paul-MN|5045360',
  'US-San Diego-CA|5391811',
  'US-San Francisco-CA|5391959',
  'US-Seattle-WA|5809844',
  'US-Silver Spring-MD|4369596',
  'US-Teaneck-NJ|5105262',
  'US-Washington-DC|4140963',
  'US-White Plains-NY|5144336',
  'UY-Montevideo|3441575',
  'UZ-Tashkent|1512569',
  'VC-Kingstown|3577887',
  'VE-Caracas|3646738',
  'VE-Maracaibo|3633009',
  'VE-Maracay|3632998',
  'VE-Valencia|3625549',
  'VG-Road Town|3577430',
  'VN-Hanoi|1581130',
  'VN-Ho Chi Minh City|1566083',
  'WS-Apia|4035413',
  'YE-Sanaa|71137',
  'YT-Mamoudzou|921815',
  'ZA-Cape Town|3369157',
  'ZA-Durban|1007311',
  'ZA-Johannesburg|993800',
  'ZA-Pretoria|964137',
  'ZM-Lusaka|909137',
  'ZW-Harare|890299'
];

const List<String> hCities = [
  'אנדורה לה ולה',
  'אבו דאבי',
  'דובאי',
  'קאבול',
  'העמק',
  'טירנה',
  'ירוואן',
  'לואנדה',
  'בואנוס איירס',
  'קורדובה',
  'רוסריו',
  'פאגו פאגו',
  'וינה',
  'אדלייד',
  'בריסביין',
  'קנברה',
  'חוף זהב',
  'הובארט',
  'מלבורן',
  'פרת',
  'סידני',
  'אורנג\'סטאד',
  'באקו',
  'סרייבו',
  'ברידג\'טאון',
  'צ\'יטגונג',
  'דאקה',
  'חולנה',
  'בריסל',
  'אואגדו',
  'סופיה',
  'מנאמה',
  'בוג\'ומבורה',
  'פורטו',
  'המילטון',
  'בנדר סרי בגוואן',
  'לה פז',
  'סנטה קרוז דה לה סיירה',
  'בלו הוריזונטה',
  'ברזיליה',
  'פורטלזה',
  'ריו דה ז\'נרו',
  'סלבדור',
  'סאו פאולו',
  'נסאו',
  'Thimphu',
  'גאבורון',
  'מינסק',
  'בלמופן',
  'קלגרי',
  'אדמונטון',
  'הליפקס',
  'מיססוגה',
  'מונטריאול',
  'אוטווה',
  'העיר קוויבק',
  'רגינה',
  'ססקטון',
  'סנט ג\'ון',
  'טורונטו',
  'ונקובר',
  'ויקטוריה',
  'ויניפג',
  'קינשאסה',
  'לובומבשי',
  'בנגוי',
  'ברזוויל',
  'ברן',
  'ז\'נבה',
  'ציריך',
  'אביג\'אן',
  'Yamoussoukro',
  'Avarua',
  'סנטיאגו',
  'דואלה',
  'יאונדה',
  'בייג\'ין',
  'צ\'נגדו',
  'צ\'ונגצ\'ינג',
  'גואנגג\'ואו',
  'חרבין',
  'קאיפנג',
  'לנז\'ו',
  'נאנצ\'ונג',
  'נאנג\'ינג',
  'פויאנג',
  'שנחאי',
  'שניאנג',
  'שנזן',
  'שיאן',
  'טאיאן',
  'טיאנג\'ין',
  'ווהאן',
  'שיאן',
  'יואיאנג',
  'ז\'ומדיאן',
  'ברנקייה',
  'בוגוטה',
  'קאלי',
  'מדין',
  'סאן חוזה',
  'הוואנה',
  'פראיה',
  'וילמסטאד',
  'ניקוסיה',
  'פראג',
  'ברלין',
  'המבורג',
  'מינכן',
  'קופנהגן',
  'רוזאו',
  'סנטיאגו דה לוס קבאלרוס',
  'סנטו דומינגו',
  'אלג\'יר',
  'גואיאקיל',
  'קיטו',
  'טאלין',
  'אל ג\'יזה',
  'אלכסנדריה',
  'קהיר',
  'אסמרה',
  'ברצלונה',
  'מדריד',
  'אדיס אבבה',
  'הלסינקי',
  'סובה',
  'סטנלי',
  'טורשאבן',
  'מרסיי',
  'פריז',
  'ליברוויל',
  'בלפסט',
  'ברמינגהאם',
  'בריסטול',
  'קרדיף',
  'אדינבורו',
  'גלזגו',
  'לידס',
  'ליברפול',
  'לונדון',
  'מנצ\'סטר',
  'שפילד',
  'טביליסי',
  'אקרה',
  'קומסי',
  'גיברלטר',
  'נווק',
  'בנג\'ול',
  'קמיין',
  'קונקרי',
  'מלאבו',
  'אַתוּנָה',
  'עיר גואטמלה',
  'ביסאו',
  'ג\'ורג\'טאון',
  'הונג קונג',
  'טגוסיגלפה',
  'זאגרב',
  'נמל',
  'בודפשט',
  'בנדונג',
  'בקסי',
  'דפוק',
  'ג\'קרטה',
  'מקאסר',
  'מדן',
  'פאלמבאנג',
  'סמרנג',
  'דרום טנג\'רנג',
  'סורביה',
  'טנג\'רנג',
  'דבלין',
  'אשדוד',
  'אשקלון',
  'בת ים',
  'באר שבע',
  'בית שמש',
  'בני ברק',
  'אילת',
  'חדרה',
  'חיפה',
  'הרצליה',
  'חולון',
  'ירושלים',
  'כפר סבא',
  'לוד',
  'מודיעין',
  'נצרת',
  'נתניה',
  'פתח תקווה',
  'רעננה',
  'רמת גן',
  'רמלה',
  'ראשון לציון',
  'תל אביב',
  'טבריה',
  'דאגלס',
  'אחמדאבאד',
  'בנגלור',
  'בומביי',
  'כלכותה',
  'צ\'נאי',
  'קוצ\'ין',
  'היידראבאד',
  'ג\'איפור',
  'קאנפור',
  'ניו דלהי',
  'פונה',
  'סוראט',
  'בגדד',
  'טהראן',
  'רייקיאוויק',
  'מילאנו',
  'רומא',
  'קינגסטון',
  'עמאן',
  'קובי',
  'קיוטו',
  'נאגויה',
  'אוסקה',
  'סאפורו',
  'טוקיו',
  'ניירובי',
  'בישקק',
  'פנום פן',
  'מורוני',
  'באסטרה',
  'פיונגיאנג',
  'בוסאן',
  'סיאול',
  'כווית',
  'ג\'ורג\' טאון',
  'אלמטי',
  'אסטנה',
  'ויינטיאן',
  'ביירות',
  'קסטריס',
  'ואדוז',
  'מונרוביה',
  'מאסרו',
  'וילנה',
  'לוקסמבורג',
  'ריגה',
  'טריפולי',
  'קזבלנקה',
  'רבאט',
  'קישינב',
  'פודגוריצה',
  'Antananarivo',
  'סקופיה',
  'במקו',
  'מנדליי',
  'רנגון',
  'אולן בטאר',
  'סייפן',
  'נואקשוט',
  'פלימות',
  'ולטה',
  'פורט לואיס',
  'לילונגווה',
  'קנקון',
  'גוודלחרה',
  'Iztapalapa',
  'מזטלן',
  'העיר מקסיקו',
  'מונטריי',
  'פוארטו ולארטה',
  'טיחואנה',
  'קוטה בהארו',
  'קואלה לומפור',
  'מאפוטו',
  'וינדהוק',
  'נומיה',
  'ניאמי',
  'אבוג\'ה',
  'לאגוס',
  'מנגואה',
  'אמסטרדם',
  'אוסלו',
  'קטמנדו',
  'אלופי',
  'אוקלנד',
  'קרייסטצ\'רץ',
  'וולינגטון',
  'מוּסקָט',
  'העיר פנמה',
  'לימה',
  'פאפיטה',
  'פורט מורסבי',
  'מנילה',
  'איסלמבאד',
  'קראצ\'י',
  'ורשה',
  'סן חואן',
  'ליסבון',
  'אסונסיון',
  'דוחה',
  'בוקרשט',
  'בלגרד',
  'מוסקבה',
  'נובוסיבירסק',
  'סנט פטרסבורג',
  'יקטרינבורג',
  'קיגאלי',
  'ג\'דה',
  'מכה',
  'מדינה',
  'ריאד',
  'הוניארה',
  'ויקטוריה',
  'חרטום',
  'אומדורמן',
  'שטוקהולם',
  'סינגפור',
  'ג\'יימסטאון',
  'לובליאנה',
  'ברטיסלבה',
  'פריטאון',
  'דקאר',
  'מוגדישו',
  'פרמריבו',
  'סאו טומה',
  'סן סלבדור',
  'חאלב',
  'דמשק',
  'אמבאפה',
  'קוקבורן טאון',
  'נדג\'מנה',
  'לומה',
  'בנגקוק',
  'דושנבה',
  'אשגבאט',
  'תוניס',
  'עדנה',
  'אנקרה',
  'אַמתָח',
  'איסטנבול',
  'איזמיר',
  'Funafuti',
  'קאושיונג',
  'טייפה',
  'דאר א-סלאם',
  'דודומה',
  'חרקוב',
  'קייב',
  'קמפלה',
  'אטלנטה',
  'אוסטין',
  'בולטימור',
  'בוסטון',
  'תְאוֹ',
  'שיקגו',
  'סינסינטי',
  'קליבלנד',
  'קולומבוס',
  'דאלאס',
  'דנבר',
  'דטרויט',
  'הרטפורד',
  'הונולולו',
  'יוסטון',
  'לייקווד',
  'לאס וגאס',
  'ליווינגסטון',
  'לוס אנג\'לס',
  'ממפיס',
  'מיאמי',
  'מילווקי',
  'מונסי',
  'גן עדן חדש',
  'ניו יורק',
  'אומהה',
  'אורלנדו',
  'פסאיץ',
  'פילדלפיה',
  'פניקס',
  'פיטסבורג',
  'פורטלנד',
  'הַשׁגָחָה עֶליוֹנָה',
  'ריצ\'מונד',
  'רוצ\'סטר',
  'סנט לואיס',
  'סנט פול',
  'סן דייגו',
  'סן פרנסיסקו',
  'סיאטל',
  'סילבר אביב',
  'Teaneck',
  'וושינגטון',
  'White Plains',
  'מונטווידאו',
  'טשקנט',
  'קינגסטאון',
  'קראקס',
  'Maracaibo',
  'מראקאי',
  'ולנסיה',
  'Road Town',
  'האנוי',
  'הו צ\'י מין סיטי',
  'אפיה',
  'צנעא',
  'מאמודזו',
  'קייפטאון',
  'דרבן',
  'יוהנסבורג',
  'פרטוריה',
  'לוסקה',
  'הרארה'
];

var x = {
  "title": "Hebcal Abu Dhabi November 2022",
  "date": "2022-11-20T08:06:20.682Z",
  "location": {
    "title": "Abu Dhabi",
    "city": "Abu Dhabi",
    "tzid": "Asia/Dubai",
    "latitude": 24.46667,
    "longitude": 54.36667,
    "cc": "AE",
    "country": "United Arab Emirates"
  }, // location
  "range": {"start": "2022-11-25", "end": "2022-11-26"}, // range
  "items": [
    {
      "title": "רֹאשׁ חוֹדֶשׁ כִּסְלֵו",
      "date": "2022-11-25",
      "hdate": "1 Kislev 5783",
      "category": "roshchodesh",
      "title_orig": "Rosh Chodesh Kislev",
      "hebrew": "ראש חודש כסלו",
      "leyning": {
        "1": "Numbers 28:1-28:3",
        "2": "Numbers 28:3-28:5",
        "3": "Numbers 28:6-28:10",
        "4": "Numbers 28:11-28:15",
        "torah": "Numbers 28:1-15"
      }, //leyning
      "link": "https://hebcal.com/h/rosh-chodesh-kislev-2022?us=js&um=api",
      "memo":
          "Start of month of Kislev on the Hebrew calendar. Kislev (כִּסְלֵו) is the 9th month of the Hebrew year, has 30 or 29 days, and corresponds to November or December on the Gregorian calendar.  רֹאשׁ חוֹדֶשׁ, transliterated Rosh Chodesh or Rosh Hodesh, is a minor holiday that occurs at the beginning of every month in the Hebrew calendar. It is marked by the birth of a new moon"
    },
    {
      "title": "הַדלָקָת נֵרוֹת: 17:15",
      "date": "2022-11-25T17:15:00+04:00",
      "category": "candles",
      "title_orig": "Candle lighting",
      "hebrew": "הדלקת נרות",
      "memo": "פָּרָשַׁת תּוֹלְדוֹת"
    },
    {
      "title": "פָּרָשַׁת תּוֹלְדוֹת",
      "date": "2022-11-26",
      "hdate": "2 Kislev 5783",
      "category": "parashat",
      "title_orig": "Parashat Toldot",
      "hebrew": "פרשת תולדות",
      "leyning": {
        "1": "Genesis 25:19-26:5",
        "2": "Genesis 26:6-26:12",
        "3": "Genesis 26:13-26:22",
        "4": "Genesis 26:23-26:29",
        "5": "Genesis 26:30-27:27",
        "6": "Genesis 27:28-28:4",
        "7": "Genesis 28:5-28:9",
        "torah": "Genesis 25:19-28:9",
        "haftarah": "Malachi 1:1-2:7",
        "maftir": "Genesis 28:7-28:9",
        "triennial": {
          "1": "Genesis 25:19-25:22",
          "2": "Genesis 25:23-25:26",
          "3": "Genesis 25:27-25:34",
          "4": "Genesis 26:1-26:5",
          "5": "Genesis 26:6-26:12",
          "6": "Genesis 26:13-26:16",
          "7": "Genesis 26:17-26:22",
          "maftir": "Genesis 26:19-26:22"
        } // triennial
      }, // leyning
      "link": "https://hebcal.com/s/toldot-20221126?us=js&um=api"
    },
    {
      "title": "הַבדָלָה: 18:10",
      "date": "2022-11-26T18:10:00+04:00",
      "category": "havdalah",
      "title_orig": "Havdalah",
      "hebrew": "הבדלה"
    }
  ]
};

var y = {
  "title": "Hebcal Abu Dhabi November 2022",
  "date": "2022-11-20T10:40:20.030Z",
  "location": {
    "title": "Abu Dhabi",
    "city": "Abu Dhabi",
    "tzid": "Asia/Dubai",
    "latitude": 24.46667,
    "longitude": 54.36667,
    "cc": "AE",
    "country": "United Arab Emirates"
  },
  "range": {"start": "2022-11-23", "end": "2022-11-26"},
  "items": [
    {
      "title": "סיגד",
      "date": "2022-11-23",
      "hdate": "29 Cheshvan 5783",
      "category": "holiday",
      "subcat": "modern",
      "title_orig": "Sigd",
      "hebrew": "סיגד",
      "link": "https://hebcal.com/h/sigd-2022?us=js&um=api",
      "memo": "Ethiopian Jewish holiday occurring 50 days after Yom Kippur"
    },
    {
      "title": "רֹאשׁ חוֹדֶשׁ כִּסְלֵו",
      "date": "2022-11-24",
      "hdate": "30 Cheshvan 5783",
      "category": "roshchodesh",
      "title_orig": "Rosh Chodesh Kislev",
      "hebrew": "ראש חודש כסלו",
      "leyning": {
        "1": "Numbers 28:1-28:3",
        "2": "Numbers 28:3-28:5",
        "3": "Numbers 28:6-28:10",
        "4": "Numbers 28:11-28:15",
        "torah": "Numbers 28:1-15"
      },
      "link": "https://hebcal.com/h/rosh-chodesh-kislev-2022?us=js&um=api",
      "memo":
          "Start of month of Kislev on the Hebrew calendar. Kislev (כִּסְלֵו) is the 9th month of the Hebrew year, has 30 or 29 days, and corresponds to November or December on the Gregorian calendar.  רֹאשׁ חוֹדֶשׁ, transliterated Rosh Chodesh or Rosh Hodesh, is a minor holiday that occurs at the beginning of every month in the Hebrew calendar. It is marked by the birth of a new moon"
    },
    {
      "title": "רֹאשׁ חוֹדֶשׁ כִּסְלֵו",
      "date": "2022-11-25",
      "hdate": "1 Kislev 5783",
      "category": "roshchodesh",
      "title_orig": "Rosh Chodesh Kislev",
      "hebrew": "ראש חודש כסלו",
      "leyning": {
        "1": "Numbers 28:1-28:3",
        "2": "Numbers 28:3-28:5",
        "3": "Numbers 28:6-28:10",
        "4": "Numbers 28:11-28:15",
        "torah": "Numbers 28:1-15"
      },
      "link": "https://hebcal.com/h/rosh-chodesh-kislev-2022?us=js&um=api",
      "memo":
          "Start of month of Kislev on the Hebrew calendar. Kislev (כִּסְלֵו) is the 9th month of the Hebrew year, has 30 or 29 days, and corresponds to November or December on the Gregorian calendar.  רֹאשׁ חוֹדֶשׁ, transliterated Rosh Chodesh or Rosh Hodesh, is a minor holiday that occurs at the beginning of every month in the Hebrew calendar. It is marked by the birth of a new moon"
    },
    {
      "title": "הַדלָקָת נֵרוֹת: 17:15",
      "date": "2022-11-25T17:15:00+04:00",
      "category": "candles",
      "title_orig": "Candle lighting",
      "hebrew": "הדלקת נרות",
      "memo": "פָּרָשַׁת תּוֹלְדוֹת"
    },
    {
      "title": "פָּרָשַׁת תּוֹלְדוֹת",
      "date": "2022-11-26",
      "hdate": "2 Kislev 5783",
      "category": "parashat",
      "title_orig": "Parashat Toldot",
      "hebrew": "פרשת תולדות",
      "leyning": {
        "1": "Genesis 25:19-26:5",
        "2": "Genesis 26:6-26:12",
        "3": "Genesis 26:13-26:22",
        "4": "Genesis 26:23-26:29",
        "5": "Genesis 26:30-27:27",
        "6": "Genesis 27:28-28:4",
        "7": "Genesis 28:5-28:9",
        "torah": "Genesis 25:19-28:9",
        "haftarah": "Malachi 1:1-2:7",
        "maftir": "Genesis 28:7-28:9",
        "triennial": {
          "1": "Genesis 25:19-25:22",
          "2": "Genesis 25:23-25:26",
          "3": "Genesis 25:27-25:34",
          "4": "Genesis 26:1-26:5",
          "5": "Genesis 26:6-26:12",
          "6": "Genesis 26:13-26:16",
          "7": "Genesis 26:17-26:22",
          "maftir": "Genesis 26:19-26:22"
        }
      },
      "link": "https://hebcal.com/s/toldot-20221126?us=js&um=api"
    },
    {
      "title": "הַבדָלָה: 18:10",
      "date": "2022-11-26T18:10:00+04:00",
      "category": "havdalah",
      "title_orig": "Havdalah",
      "hebrew": "הבדלה"
    }
  ]
};

var z = {
  "title": "Hebcal Beersheba October 2022",
  "date": "2022-11-20T11:54:07.475Z",
  "location": {
    "title": "Beersheba, Israel",
    "city": "Beersheba",
    "tzid": "Asia/Jerusalem",
    "latitude": 31.25181,
    "longitude": 34.7913,
    "cc": "IL",
    "country": "Israel",
    "admin1": "Southern District",
    "asciiname": "Beersheba",
    "geo": "geoname",
    "geonameid": 295530
  },
  "range": {"start": "2022-10-05", "end": "2022-10-10"},
  "items": [
    {
      "title": "יוֹם כִּפּוּר",
      "date": "2022-10-05",
      "hdate": "10 Tishrei 5783",
      "category": "holiday",
      "subcat": "major",
      "yomtov": true,
      "title_orig": "Yom Kippur",
      "hebrew": "יום כפור",
      "leyning": {
        "1": "Leviticus 16:1-16:6",
        "2": "Leviticus 16:7-16:11",
        "3": "Leviticus 16:12-16:17",
        "4": "Leviticus 16:18-16:24",
        "5": "Leviticus 16:25-16:30",
        "6": "Leviticus 16:31-16:34",
        "torah": "Leviticus 16:1-34; Numbers 29:7-11",
        "haftarah": "Isaiah 57:14-58:14",
        "maftir": "Numbers 29:7-29:11"
      },
      "link": "https://hebcal.com/h/yom-kippur-2022?i=on&us=js&um=api",
      "memo": "Day of Atonement"
    },
    {
      "title": "הַבדָלָה: 18:57",
      "date": "2022-10-05T18:57:00+03:00",
      "category": "havdalah",
      "title_orig": "Havdalah",
      "hebrew": "הבדלה",
      "memo": "יוֹם כִּפּוּר"
    },
    {
      "title": "הַדלָקָת נֵרוֹת: 18:00",
      "date": "2022-10-07T18:00:00+03:00",
      "category": "candles",
      "title_orig": "Candle lighting",
      "hebrew": "הדלקת נרות",
      "memo": "פָּרָשַׁת הַאֲזִינוּ"
    },
    {
      "title": "פָּרָשַׁת הַאֲזִינוּ",
      "date": "2022-10-08",
      "hdate": "13 Tishrei 5783",
      "category": "parashat",
      "title_orig": "Parashat Ha'Azinu",
      "hebrew": "פרשת האזינו",
      "leyning": {
        "1": "Deuteronomy 32:1-32:6",
        "2": "Deuteronomy 32:7-32:12",
        "3": "Deuteronomy 32:13-32:18",
        "4": "Deuteronomy 32:19-32:28",
        "5": "Deuteronomy 32:29-32:39",
        "6": "Deuteronomy 32:40-32:43",
        "7": "Deuteronomy 32:44-32:52",
        "torah": "Deuteronomy 32:1-52",
        "haftarah": "II Samuel 22:1-51",
        "maftir": "Deuteronomy 32:48-32:52"
      },
      "link": "https://hebcal.com/s/haazinu-20221008?i=on&us=js&um=api"
    },
    {
      "title": "הַבדָלָה: 18:54",
      "date": "2022-10-08T18:54:00+03:00",
      "category": "havdalah",
      "title_orig": "Havdalah",
      "hebrew": "הבדלה"
    },
    {
      "title": "עֶרֶב סוּכּוֹת",
      "date": "2022-10-09",
      "hdate": "14 Tishrei 5783",
      "category": "holiday",
      "subcat": "major",
      "title_orig": "Erev Sukkot",
      "hebrew": "ערב סוכות",
      "link": "https://hebcal.com/h/sukkot-2022?i=on&us=js&um=api",
      "memo": "Feast of Booths"
    },
    {
      "title": "הַדלָקָת נֵרוֹת: 17:58",
      "date": "2022-10-09T17:58:00+03:00",
      "category": "candles",
      "title_orig": "Candle lighting",
      "hebrew": "הדלקת נרות",
      "memo": "עֶרֶב סוּכּוֹת"
    },
    {
      "title": "סוּכּוֹת א׳",
      "date": "2022-10-10",
      "hdate": "15 Tishrei 5783",
      "category": "holiday",
      "subcat": "major",
      "yomtov": true,
      "title_orig": "Sukkot I",
      "hebrew": "סוכות א׳",
      "leyning": {
        "1": "Leviticus 22:26-23:3",
        "2": "Leviticus 23:4-23:14",
        "3": "Leviticus 23:15-23:22",
        "4": "Leviticus 23:23-23:32",
        "5": "Leviticus 23:33-23:44",
        "torah": "Leviticus 22:26-23:44; Numbers 29:12-16",
        "haftarah": "Zechariah 14:1-21",
        "maftir": "Numbers 29:12-29:16"
      },
      "link": "https://hebcal.com/h/sukkot-2022?i=on&us=js&um=api",
      "memo": "Feast of Booths"
    },
    {
      "title": "הַבדָלָה: 18:51",
      "date": "2022-10-10T18:51:00+03:00",
      "category": "havdalah",
      "title_orig": "Havdalah",
      "hebrew": "הבדלה",
      "memo": "סוּכּוֹת א׳"
    }
  ]
};

var w = {
  //13.9.22
  "title": "Hebcal Beersheba September 2022",
  "date": "2022-11-21T09:43:10.005Z",
  "location": {
    "title": "Beersheba, Israel",
    "city": "Beersheba",
    "tzid": "Asia/Jerusalem",
    "latitude": 31.25181,
    "longitude": 34.7913,
    "cc": "IL",
    "country": "Israel",
    "admin1": "Southern District",
    "asciiname": "Beersheba",
    "geo": "geoname",
    "geonameid": 295530
  },
  "range": {"start": "2022-09-16", "end": "2022-09-17"},
  "items": [
    {
      "title": "הַדלָקָת נֵרוֹת: 18:27",
      "date": "2022-09-16T18:27:00+03:00",
      "category": "candles",
      "title_orig": "Candle lighting",
      "hebrew": "הדלקת נרות",
      "memo": "פָּרָשַׁת כִּי־תָבוֹא"
    },
    {
      "title": "סליחות",
      "date": "2022-09-17",
      "hdate": "21 Elul 5782",
      "category": "holiday",
      "subcat": "minor",
      "title_orig": "Leil Selichot",
      "hebrew": "סליחות",
      "link": "https://hebcal.com/h/leil-selichot-2022?i=on&us=js&um=api",
      "memo": "Prayers for forgiveness in preparation for the High Holidays"
    },
    {
      "title": "פָּרָשַׁת כִּי־תָבוֹא",
      "date": "2022-09-17",
      "hdate": "21 Elul 5782",
      "category": "parashat",
      "title_orig": "Parashat Ki Tavo",
      "hebrew": "פרשת כי־תבוא",
      "leyning": {
        "1": "Deuteronomy 26:1-26:11",
        "2": "Deuteronomy 26:12-26:15",
        "3": "Deuteronomy 26:16-26:19",
        "4": "Deuteronomy 27:1-27:10",
        "5": "Deuteronomy 27:11-28:6",
        "6": "Deuteronomy 28:7-28:69",
        "7": "Deuteronomy 29:1-29:8",
        "torah": "Deuteronomy 26:1-29:8",
        "haftarah": "Isaiah 60:1-22",
        "maftir": "Deuteronomy 29:6-29:8"
      },
      "link": "https://hebcal.com/s/ki-tavo-20220917?i=on&us=js&um=api"
    },
    {
      "title": "הַבדָלָה: 19:20",
      "date": "2022-09-17T19:20:00+03:00",
      "category": "havdalah",
      "title_orig": "Havdalah",
      "hebrew": "הבדלה"
    }
  ]
};

