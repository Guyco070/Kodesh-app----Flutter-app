import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/helpers/city_display.dart';

void main() {
  test('drops the country code prefix', () {
    expect(cityDisplayName('AR-Buenos Aires'), 'Buenos Aires');
    expect(cityDisplayName('IL-ירושלים'), 'ירושלים');
  });

  test('keeps names without a prefix as they are', () {
    expect(cityDisplayName('Jerusalem'), 'Jerusalem');
    expect(cityDisplayName('Tel-Aviv'), 'Tel-Aviv');
  });

  test('cityLabel finds the name in the language and strips the code', () {
    const list = [
      {
        'eNameAndCode': 'IL-Jerusalem|281184',
        'en': 'IL-Jerusalem',
        'he': 'IL-ירושלים',
      },
    ];
    expect(cityLabel('IL-Jerusalem|281184', 'he', list), 'ירושלים');
    expect(cityLabel('IL-Jerusalem|281184', 'ru', list), 'Jerusalem');
    expect(cityLabel('US-Boston|123', 'he', list), 'Boston');
  });
}
