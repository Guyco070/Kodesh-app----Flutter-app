import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as df;
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
// import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsBar extends StatefulWidget {
  SettingsBar({
    super.key,
    required this.isOnlyShabat,
    required this.updateIsOnlyShabat,
    required this.setIsLoading,
  });
  final bool isOnlyShabat;
  final Function updateIsOnlyShabat;
  final Function setIsLoading;

  @override
  State<SettingsBar> createState() => _SettingsBarState();
}

class _SettingsBarState extends State<SettingsBar> {
  bool _isExpanded = true;

  DropdownMenuItem<String> buildMenuItem(Map item, String lang) {
    return DropdownMenuItem(
        value: item['eNameAndCode'],
        child: Text(
          item[lang],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
  }

  buildSelectedMenuItem(String lang) {
    return cities.map<Widget>((Map item) {
      return Container(
        // margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        child: Text(
          item[lang],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context, listen: false);
    var lang = Provider.of<LanguageChangeProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.blueGrey,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200]),
      child: Column(
        children: [
          if(!_isExpanded) const SizedBox(height: 15,),
          IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: DropdownButtonFormField<String>(
                        borderRadius: BorderRadius.circular(15),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 21,),
                        isDense: false,
                        iconEnabledColor: Colors.white,
                        decoration: const InputDecoration(
                            isCollapsed: true, enabledBorder: InputBorder.none),
                        selectedItemBuilder: (_) => buildSelectedMenuItem(
                            lang.currentLocale.languageCode),
                        value: events.city,
                        isExpanded: true,
                        alignment: AlignmentDirectional.center,
                        items: cities
                            .map<DropdownMenuItem<String>>((items) =>
                                buildMenuItem(
                                    items, lang.currentLocale.languageCode))
                            .toList(),
                        onChanged: (value) {
                          events.setCity(value ?? events.city,
                              setIsLoading: widget.setIsLoading);
                        }),
                  ),
                  VerticalDivider(
                    color: Theme.of(context).primaryColor,
                    indent: 10,
                    endIndent: 10,
                    width: 40,
                    thickness: 2,
                  ),
                  
                      ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: events.startDate,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 365)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)));
                            if (newDate != null) {
                              events.setStartDate(newDate,
                                  setIsLoading: widget.setIsLoading);
                            }
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                          label: Text(df.DateFormat('dd/MM/yyyy')
                              .format(events.startDate))),
                ],
              ),
            ),
          ),
          // _isExpanded ? Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: CuperinoTextCheckSwitch(
          //     value: widget.isOnlyShabat,
          //     onChanged: widget.updateIsOnlyShabat,
          //     text: appLocalizations.onlyShabat,
          //   ),
          // ) :
          if(_isExpanded) Align(
            alignment: Alignment.topRight,
            child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                            onPressed: () => events.setStartDate(
                                events.startDate.subtract(const Duration(days: 1)),
                                setIsLoading: widget.setIsLoading),
                            icon: const Icon(Icons.remove, size: 20)),
                            IconButton(
                                onPressed: () => events.setStartDate(
                                    events.startDate.add(const Duration(days: 1)),
                                    setIsLoading: widget.setIsLoading),
                                icon: const Icon(Icons.add, size: 20,)),
                          ],
                        ),
            ),
          ),
          Container(padding: const EdgeInsets.only(top: 0,), height: 30,child: TextButton(onPressed: () =>  widget.updateIsOnlyShabat(), child: Text(appLocalizations.onlyShabat, style: TextStyle(color: widget.isOnlyShabat ? Colors.blue : Colors.grey, fontSize: 12),)),),
          Container(
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: _isExpanded ? 22 : 20,
                    onPressed: () {
                      DateTime today = DateTime.now();
                      if (events.items == null ||
                          df.DateFormat('dd/MM/yy').format(today) !=
                              df.DateFormat('dd/MM/yy')
                                  .format(events.startDate)) {
                        events.setStartDate(DateTime.now(),
                            setIsLoading: widget.setIsLoading);
                      }
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Theme.of(context).primaryColor,
                    )),
                Text(
                  '${appLocalizations.currentDate}: ${df.DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                  style: const TextStyle(fontSize: 12),
                ),
                // IconButton(
                //     onPressed: () {
                //       setState(() {
                //         _isExpanded = !_isExpanded;
                //       });
                //     },
                //     icon: Icon(_isExpanded ? Icons.keyboard_double_arrow_up : Icons.keyboard_double_arrow_down, size: _isExpanded ? 22 : 20,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
