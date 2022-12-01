import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as df;
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:provider/provider.dart';

class SettingsBar extends StatelessWidget {
  const SettingsBar({
    super.key,
    required this.isOnlyShabat,
    required this.updateIsOnlyShabat,
    required this.setIsLoading,
  });
  final bool isOnlyShabat;
  final Function updateIsOnlyShabat;
  final Function setIsLoading;

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item.split('|')[0],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
  }

  buildSelectedMenuItem() {
    return cities.map<Widget>((String item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        child: Text(
          item.split('|')[0],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context, listen: false);

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
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: DropdownButtonFormField<String>(
                      isDense: false,
                      iconEnabledColor: Colors.white,
                      decoration: const InputDecoration(
                          isCollapsed: true, enabledBorder: InputBorder.none),
                      selectedItemBuilder: (_) => buildSelectedMenuItem(),
                      value: events.city,
                      isExpanded: true,
                      alignment: AlignmentDirectional.center,
                      items: cities
                          .map<DropdownMenuItem<String>>(buildMenuItem)
                          .toList(),
                      onChanged: (value) {
                        events.setCity(value ?? events.city,
                            setIsLoading: setIsLoading);
                      }),
                ),
                VerticalDivider(
                  color: Theme.of(context).primaryColor,
                  indent: 10,
                  endIndent: 10,
                  width: 40,
                  thickness: 2,
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () => events.setStartDate(
                            events.startDate.add(const Duration(days: 1)),
                            setIsLoading: setIsLoading),
                        icon: const Icon(Icons.add)),
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
                                setIsLoading: setIsLoading);
                          }
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                        label: Text(df.DateFormat('dd/MM/yyyy')
                            .format(events.startDate))),
                    IconButton(
                        onPressed: () => events.setStartDate(
                            events.startDate.subtract(const Duration(days: 1)),
                            setIsLoading: setIsLoading),
                        icon: const Icon(Icons.remove)),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('הצג רק שבת'),
                ),
                CupertinoSwitch(
                    activeColor: Theme.of(context).primaryColor,
                    value: isOnlyShabat,
                    onChanged: (_) => updateIsOnlyShabat()),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'תאריך נוכחי: ${df.DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                textDirection: TextDirection.rtl,
              ),
              IconButton(
                  iconSize: 22,
                  onPressed: () {
                    DateTime today = DateTime.now();
                    if (events.items == null ||
                        df.DateFormat('dd/MM/yy').format(today) !=
                            df.DateFormat('dd/MM/yy')
                                .format(events.startDate)) {
                      events.setStartDate(DateTime.now(),
                          setIsLoading: setIsLoading);
                    }
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
