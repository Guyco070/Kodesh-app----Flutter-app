import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as df;
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/screens/event_screen.dart';
// import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../helpers/dates.dart';

class SettingsBar extends StatefulWidget {
  const SettingsBar({
    super.key,
    required this.isOnlyShabat,
    required this.updateIsOnlyShabat,
    required this.setIsLoading,
    required this.setIsLoadingZmanim,
    required this.viewState,
    required this.isHebrewDate,
    required this.updateIsHebrewDate,
  });

  final bool isOnlyShabat;
  final Function updateIsOnlyShabat;
  final Function setIsLoading;
  final Function setIsLoadingZmanim;
  final ViewState viewState;
  final bool isHebrewDate;
  final Function updateIsHebrewDate;

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
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: ((child, animation) =>
              ScaleTransition(scale: animation, child: child)),
          child: Text(
            item[lang],
            key: ValueKey<String>(item[lang]),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context, listen: false);
    var lang = Provider.of<LanguageChangeProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return TweenAnimationBuilder(
        duration: const Duration(seconds: 3),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, val, child) {
          return Opacity(
            opacity: val,
            child: Container(
              padding: EdgeInsets.all((val - 1) * -20),
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
                  if (!_isExpanded)
                    const SizedBox(
                      height: 15,
                    ),
                  IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor),
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: DropdownButtonFormField<String>(
                                    borderRadius: BorderRadius.circular(15),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 21,
                                    ),
                                    isDense: false,
                                    iconEnabledColor: Colors.white,
                                    decoration: const InputDecoration(
                                        isCollapsed: true,
                                        enabledBorder: InputBorder.none),
                                    selectedItemBuilder: (_) =>
                                        buildSelectedMenuItem(
                                            lang.currentLocale.languageCode),
                                    value: events.city,
                                    isExpanded: true,
                                    alignment: AlignmentDirectional.center,
                                    items: cities
                                        .map<DropdownMenuItem<String>>(
                                            (items) => buildMenuItem(
                                                items,
                                                lang.currentLocale
                                                    .languageCode))
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != events.city) {
                                        events.setCity(value ?? events.city,
                                            setIsLoading: widget.setIsLoading,
                                            setIsLoadingZmanim: widget.setIsLoadingZmanim,
                                          );
                                      }
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
                                        firstDate: DateTime.now().subtract(
                                            const Duration(days: 365)),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)));
                                    if (newDate != null) {
                                      events.setStartDate(newDate,
                                          setIsLoading: widget.setIsLoading,
                                          setIsLoadingZmanim: widget.setIsLoadingZmanim,);
                                    }
                                  },
                                  icon:
                                      const Icon(Icons.calendar_month_outlined),
                                  label: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: ((child, animation) =>
                                        ScaleTransition(
                                            scale: animation, child: child)),
                                    child: Text(
                                        key: ValueKey<String>(
                                            df.DateFormat('dd/MM/yyyy')
                                                .format(events.startDate)),
                                        df.DateFormat('dd/MM/yyyy')
                                            .format(events.startDate)),
                                  )),
                            ],
                          ),
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
                  if (_isExpanded)
                    Align(
                      alignment: Alignment(
                          LanguageChangeProvider.isDirectionRTL(
                                  events.currentLocale.languageCode)
                              ? -1
                              : 1,
                          5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => events.setStartDate(
                                    events.startDate
                                        .subtract(const Duration(days: 1)),
                                    setIsLoading: widget.setIsLoading,
                                    setIsLoadingZmanim: widget.setIsLoadingZmanim),
                                icon: const Icon(Icons.remove, size: 20)),
                            IconButton(
                                onPressed: () => events.setStartDate(
                                    events.startDate
                                        .add(const Duration(days: 1)),
                                    setIsLoading: widget.setIsLoading,
                                    setIsLoadingZmanim: widget.setIsLoadingZmanim),
                                icon: const Icon(
                                  Icons.add,
                                  size: 20,
                                )),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 30,),
                        Expanded(
                          child: TextButton(
                            onPressed: () => widget.updateIsOnlyShabat(),
                            child: Text(
                              widget.viewState == ViewState.events
                                  ? widget.isOnlyShabat ? appLocalizations.viewAllEvents : appLocalizations.onlyShabat
                                  : appLocalizations.fromNowOn,
                              style: TextStyle(
                                  color: widget.isOnlyShabat
                                      ? Colors.blue
                                      : Colors.grey,
                                  fontSize: 12),
                            )),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () => widget.updateIsHebrewDate(),
                            child: Text(
                              widget.isHebrewDate
                                  ? appLocalizations.viewForeignDates
                                  : appLocalizations.viewHebrewDates,
                              style: TextStyle(
                                  color: widget.isHebrewDate
                                      ? Colors.blue
                                      : Colors.grey,
                                  fontSize: 12),
                            )),
                        ),
                        const SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                                  iconSize: _isExpanded ? 22 : 20,
                                  onPressed: () {
                                    DateTime today = DateTime.now();
                                    if (events.eventsItems == null ||
                                        df.DateFormat('dd/MM/yy').format(today) !=
                                            df.DateFormat('dd/MM/yy')
                                                .format(events.startDate)) {
                                      events.setStartDate(DateTime.now(),
                                          setIsLoading: widget.setIsLoading,
                                          setIsLoadingZmanim: widget.setIsLoadingZmanim);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Theme.of(context).primaryColor,
                                  )),
                         Text('${appLocalizations.currentDate}: ',
                                style: const TextStyle(fontSize: 12),
                              ),
                        SizedBox(
                          width: 130,
                          child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder: ((child, animation) =>
                                    ScaleTransition(scale: animation, child: child)),
                                child: Row(
                                  key: ValueKey<String>(events.isHebrewDate ? events.hebrewDates!.isEmpty ? '  ' : events.hebrewDates![getDateTimeSetToZero(DateTime.now())]! : df.DateFormat('dd/MM/yyyy').format(DateTime.now())),
                                  children: [ 
                                    if(events.isHebrewDate && events.hebrewDates!.isEmpty) ...{
                                      Text(
                                          events.isHebrewDate ? events.hebrewDates!.isEmpty ? '  ' : events.hebrewDates![getDateTimeSetToZero(DateTime.now())]! : df.DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const CupertinoActivityIndicator()
                                    }else...{
                                      Text(
                                          events.isHebrewDate && events.hebrewDates!.isNotEmpty ? events.hebrewDates![getDateTimeSetToZero(DateTime.now())]! : df.DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                    },
  
                              
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
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          );
        });
  }
}
