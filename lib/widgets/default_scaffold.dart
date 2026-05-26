import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/app_drawer.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultScaffold extends StatefulWidget {
  const DefaultScaffold({super.key, required this.title, required this.body, this.setIsLoading});
  final String title;
  final Widget body;
  final Function? setIsLoading;

  @override
  State<DefaultScaffold> createState() => _DefaultScaffoldState();
}

class _DefaultScaffoldState extends State<DefaultScaffold> {
  bool _isLoading = false;

  DropdownMenuItem<String> buildMenuItem(Locale item) {
    return DropdownMenuItem(
        alignment: Alignment.center,
        value: item.languageCode,
        child: Text(
          '${item.languageCode} - ${L10n.names[item.languageCode]!['locale']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textDirection: TextDirection.ltr,
        ));
  }

  buildSelectedMenuItem() {
    return L10n.all.map<Widget>((Locale item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        child: Text(
          item.languageCode,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList();
  }

  getLangDropDown(LanguageChangeProvider lang) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          lang.currentLocale.languageCode,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        items: L10n.all.map<DropdownMenuItem<String>>(buildMenuItem).toList(),
        value: lang.currentLocale.languageCode,
        onChanged: (value) {
          if (value != lang.currentLocale.languageCode) {
            lang.changeLocale(
              value ?? lang.currentLocale.languageCode
            );
            Provider.of<Events>(context, listen: false)
                .changeLocale(value ?? lang.currentLocale.languageCode,
                    setIsLoading: widget.setIsLoading)
                .then((_) => Reminders(context));
          }
        },
        customButton: langIcon(lang),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          iconEnabledColor: Colors.white,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 8,
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true)
          )
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 14, right: 14)
        )
      )
    );
  }

  FittedBox langIcon(lang) => FittedBox(
      child: Row(
        children: [
          const Icon(
            Icons.language_outlined
          ),
          const SizedBox(
            width: 3
          ),
          Text(
            lang.currentLocale.languageCode,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
            textDirection: TextDirection.rtl
          )
        ]
      )
    );

  @override
  Widget build(BuildContext context) {
    LanguageChangeProvider lang =
        Provider.of<LanguageChangeProvider>(context, listen: false);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
          title:
              _isLoading ? AppLocalizations.of(context)!.loading : widget.title,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.drag_indicator_outlined));
          }),
          trailing: getLangDropDown(lang)
          //  Container(
          //   height: 60,
          //   width: 30,
          //   child: DropdownButton2<String>(
          //       hint: Text(lang.currentLocale.languageCode),
          //       dropdownWidth: 150,
          //       isDense: false,
          //       // iconEnabledColor: Colors.white,
          //       icon: const Icon(Icons.language_outlined),
          //       underline: Container(),
          //       selectedItemBuilder: (_) => buildSelectedMenuItem(),
          //       value: lang.currentLocale.languageCode,
          //       isExpanded: true,
          //       alignment: AlignmentDirectional.center,
          //       items: L10n.all
          //           .map<DropdownMenuItem<String>>(buildMenuItem)
          //           .toList(),
          //       onChanged: (value) {
          //         lang.changeLocale(
          //           value ?? lang.currentLocale.languageCode,
          //         );
          //         Provider.of<Events>(context, listen: false).changeLocale(
          //             value ?? lang.currentLocale.languageCode,
          //             setIsLoading: setIsLoading);
          //       }),
          // ),
          ),
      //  IconButton(onPressed: () => Provider.of<LanguageChangeProvider>(context, listen: false).changeLocale(L10n.all[0].languageCode) ,icon: const Icon(Icons.language_outlined)),),
      // AppBar(
      //   title: Text(
      //     title,
      //     textDirection: TextDirection.rtl,
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: _isLoading
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
