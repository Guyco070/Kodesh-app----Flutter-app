import 'package:flutter/material.dart';

class CitySearchDelegate extends SearchDelegate<Map?> {
  CitySearchDelegate({required this.cities, required this.lang});

  final List<Map> cities;
  final String lang;

  @override
  List<Widget> buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildList();

  @override
  Widget buildSuggestions(BuildContext context) => _buildList();

  Widget _buildList() {
    final q = query.toLowerCase();
    final filtered = q.isEmpty
        ? cities
        : cities.where((c) {
            final name = ((c[lang] ?? c['en'] ?? '') as String).toLowerCase();
            return name.contains(q);
          }).toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, i) {
        final city = filtered[i];
        final name = (city[lang] ?? city['en'] ?? '') as String;
        return ListTile(title: Text(name), onTap: () => close(context, city));
      },
    );
  }
}
