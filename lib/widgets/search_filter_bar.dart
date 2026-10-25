import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              controller.text.isNotEmpty
                  ? IconButton(
                    tooltip: AppLocalizations.of(context)!.clearSearch,
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                  )
                  : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          isDense: true,
        ),
      ),
    );
  }
}
