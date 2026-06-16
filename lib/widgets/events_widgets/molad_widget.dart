import 'package:flutter/material.dart';
import 'package:kodesh_app/models/molad.dart';

class MoladWidget extends StatelessWidget {
  const MoladWidget({super.key, required this.data});
  final Molad data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.nights_stay_outlined),
      title: Text(data.title),
      subtitle: data.titleOrig != null ? Text(data.titleOrig!) : null,
    );
  }
}
