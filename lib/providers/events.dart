import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:http/http.dart';

class Events with ChangeNotifier {
  List<Event> _items = [];
  String city = 'IL-Jerusalem|281184';

  List<Event> get items {
    return [..._items];
  }

  setCity(String newCity) {
    city = newCity;
    notifyListeners();
  }

  tryFetch() async {
    var response;
    var url = Uri.parse(
        'https://www.hebcal.com/shabbat?cfg=json&zip=${city.split('|')[1]}&M=on&lg=he');
    response = await get(url);
    if ((jsonDecode(response.body) as Map<String, dynamic>).keys.contains('error')) {
      url = Uri.parse(
          'https://www.hebcal.com/shabbat?cfg=json&city=${city.split('|')[0]}&M=on&lg=he');
      response = await get(url);
    }

    return response;
  }

  Future<Event> fetchAndSetProducts([
    bool filterByUser = false,
  ]) async {
    try {
      final response = await tryFetch();
      // print(response.body);
      final extractData = jsonDecode(response.body) as Map<String, dynamic>;

      // print(extractData['items'].toString() );
      String entryDate = extractData['items'][0]['date'];
      String releaseDate = extractData['items'][3]['date'];
      if (entryDate.contains('T')) {
        entryDate = entryDate.substring(0, entryDate.length - 6).toString();
      }
      if (releaseDate.contains('T')) {
        releaseDate =
            releaseDate.substring(0, releaseDate.length - 6).toString();
      }
      // print(entryDate);
      // print(releaseDate);

      // final List<Event> loadedProducts = [];
      // extractData.forEach((prodId, prodData) {
      //   loadedProducts.add(Event(
      //     title: prodData['title'] as String,
      //   ));
      //   _items = loadedProducts;
      //   notifyListeners();
      // });

      _items = [
        Event(
          title: extractData['items'][0]['hebrew'],
          parasha: extractData['items'][1]['title'],
          entryDate: DateTime.tryParse(entryDate),
          releaseDate: DateTime.tryParse(releaseDate),
        )
      ];
      return _items[0];
    } catch (error) {
      rethrow;
    }
  }
}
