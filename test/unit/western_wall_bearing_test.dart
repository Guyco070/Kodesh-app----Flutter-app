import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/helpers/western_wall_bearing.dart';

void main() {
  test('New York faces north-east to Jerusalem', () {
    expect(bearingToWesternWall(40.7128, -74.0060), closeTo(54.5, 1.5));
  });

  test('Tel Aviv faces east-south-east', () {
    expect(bearingToWesternWall(32.0853, 34.7818), closeTo(130, 15));
  });

  test('Buenos Aires faces east', () {
    expect(bearingToWesternWall(-34.6037, -58.3816), closeTo(64, 6));
  });

  test('bearingFromCity reads the city coordinates', () {
    expect(bearingFromCity('IL-Jerusalem|281184'), isNotNull);
    expect(bearingFromCity('XX-Nowhere'), isNull);
  });
}
