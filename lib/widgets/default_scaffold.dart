import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/widgets/app_drawer.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

class DefaultScaffold extends StatefulWidget {
  const DefaultScaffold({
    super.key,
    required this.title,
    required this.body,
    this.setIsLoading,
  });
  final String title;
  final Widget body;
  final Function? setIsLoading;

  @override
  State<DefaultScaffold> createState() => _DefaultScaffoldState();
}

class _DefaultScaffoldState extends State<DefaultScaffold> {
  bool _isLoading = false;

  DropdownItem<String> _buildMenuItem(Locale item, String currentLang) {
    final isSelected = item.languageCode == currentLang;
    final primaryColor = Theme.of(context).colorScheme.primary;
    return DropdownItem(
      alignment: Alignment.centerLeft,
      value: item.languageCode,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: null,
        child: Row(
          children: [
            Icon(
              Icons.check,
              size: 18,
              color: isSelected ? primaryColor : Colors.transparent,
            ),
            const SizedBox(width: 8),
            Text(
              '${item.languageCode} - ${L10n.names[item.languageCode]!['locale']}',
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                fontSize: 16,
                color: isSelected ? primaryColor : null,
              ),
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }

  getLangDropDown(LanguageChangeProvider lang) {
    final currentLang = lang.currentLocale.languageCode;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          lang.currentLocale.languageCode,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
        items:
            L10n.all
                .map<DropdownItem<String>>(
                  (item) => _buildMenuItem(item, currentLang),
                )
                .toList(),
        valueListenable: ValueNotifier<String?>(
          lang.currentLocale.languageCode,
        ),
        onChanged: (String? value) {
          if (value != null && value != lang.currentLocale.languageCode) {
            lang.changeLocale(value);
            Provider.of<Events>(
              context,
              listen: false,
            ).changeLocale(value, setIsLoading: widget.setIsLoading);
          }
        },
        customButton: langIcon(lang),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 14, right: 14),
          elevation: 0,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        iconStyleData: const IconStyleData(iconEnabledColor: Colors.white),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          padding: null,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          elevation: 8,
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  FittedBox langIcon(LanguageChangeProvider lang) {
    final code = lang.currentLocale.languageCode;
    final localeName = L10n.names[code]!['locale']!;
    return FittedBox(
      child: Row(
        children: [
          const Icon(Icons.language_outlined),
          const SizedBox(width: 4),
          Text(
            localeName,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageChangeProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: _isLoading ? appLocalizations.loading : widget.title,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.drag_indicator_outlined),
            );
          },
        ),
        trailing: getLangDropDown(lang),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : widget.body,
      persistentFooterAlignment: AlignmentDirectional.topCenter,
    );
  }

  setIsLoading(bool newVal) {
    setState(() {
      _isLoading = newVal;
    });
  }
}
