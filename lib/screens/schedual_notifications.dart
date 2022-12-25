import 'package:flutter/material.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/schedual_notifications_widgets/choose_time_before_widget.dart';
import 'package:kodesh_app/widgets/schedual_notifications_widgets/choose_time_in_day_widget.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchedualNotficationsScreen extends StatefulWidget {
  const SchedualNotficationsScreen({super.key});
  static String routeName = '/schedual-notfications';

  @override
  State<SchedualNotficationsScreen> createState() =>
      _SchedualNotficationsScreenState();
}

class _SchedualNotficationsScreenState
    extends State<SchedualNotficationsScreen> {
  bool tefilin = false;
  bool preys = false;
  bool roshChodesh = false;
  String tefilinTime = '';

  bool _isLoading = false;

  // TextEditingController? tefilinController;

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
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        child: Text(
          item[lang],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var reminders = Provider.of<Reminders>(context);
    var lang = Provider.of<LanguageChangeProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    var devider = Container(
          margin: const EdgeInsets.symmetric(vertical: 7),
          height: 7,
          decoration: BoxDecoration(border: const Border(top: BorderSide(width: 1, color: Colors.grey), bottom: BorderSide(width: 1, color: Colors.grey),), color: Colors.grey[200]));

    shabatAndHolidaysThingsToRemindList() {
      return reminders.allShabatAndHolidaysThingsToRemindList(context).map((e) {
        return TextCheckBox(
            value: reminders.shabatAndHolidaysThingsToRemindList.contains(e),
            text: reminders.allShabatAndHolidaysThingsToRemindMap(
                context)[e]!['text'] as String,
            onChanged: (isCheked) {
              isCheked
                  ? reminders.shabatAndHolidaysThingsToRemindList.add(e)
                  : reminders.shabatAndHolidaysThingsToRemindList.remove(e);
              reminders.setShabatAndHolidaysThingsToRemindList(
                  newShabatAndHolidaysThingsToRemindList:
                      reminders.shabatAndHolidaysThingsToRemindList);
            });
      }).toList();
    }

    nerotHanukkahElements() {
      return [
        const SizedBox(
          height: 7,
        ),
        const Divider(
          height: 15,
          thickness: 1.5,
          indent: 60,
          endIndent: 60,
        ),
        const SizedBox(
          height: 7,
        ),
        ChooseTimeBeforeWidget(
          hoursValue: reminders.beforeNerotHanukkahHours,
          minutesValue: reminders.beforeNerotHanukkahMinutes,
          setHours: reminders.setNerotHanukkahHours,
          setMinutess: reminders.setNerotHanukkahMinutes,
          localizedHelpText:
              appLocalizations.remindMeXhoursAndYMinutesBeforeNerotHanukkah,
        ),
      ];
    }

    shabatAndHolidaysElements() {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocalizations.city,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            ),
            Container(
              // remider city drop down button - start
              margin: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width / 2.3,
              child: DropdownButtonFormField<String>(
                  isDense: false,
                  decoration: const InputDecoration(
                      isCollapsed: true, enabledBorder: InputBorder.none),
                  selectedItemBuilder: (_) =>
                      buildSelectedMenuItem(lang.currentLocale.languageCode),
                  value: reminders.reminderCity,
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  items: cities
                      .map<DropdownMenuItem<String>>((items) =>
                          buildMenuItem(items, lang.currentLocale.languageCode))
                      .toList(),
                  onChanged: (value) {
                    reminders.setReminderCity(value ?? reminders.reminderCity);
                  }),
            ), // remider city drop down button - end
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        const Divider(
          height: 15,
          thickness: 1.5,
          indent: 60,
          endIndent: 60,
        ),
        const SizedBox(
          height: 7,
        ),
        ChooseTimeBeforeWidget(
          hoursValue: reminders.beforeShabatHours,
          minutesValue: reminders.beforeShabatMinutes,
          setHours: reminders.setShabatAndHolidaysShabatHours,
          setMinutess: reminders.setShabatAndHolidaysShabatMinutes,
          localizedHelpText:
              appLocalizations.remindMeXhoursAndYMinutesBeforeShbatAndHolidays,
        ),
        const SizedBox(
          height: 7,
        ),
        const Divider(
          height: 15,
          thickness: 1.5,
          indent: 60,
          endIndent: 60,
        ),
        const SizedBox(
          height: 7,
        ),
        Text(appLocalizations.whatToRemindSettings),
        ...shabatAndHolidaysThingsToRemindList(),
        const SizedBox(
          height: 7,
        ),
        const Divider(height: 15, thickness: 1.5, indent: 15, endIndent: 15,),
        const SizedBox(
          height: 7,
        ),
        CuperinoTextCheckSwitch(
          value: reminders.shabatAndHolidaysCandles,
          onChanged: () => reminders.setShabatAndHolidaysCandles(),
          text: appLocalizations.remindCandleLightningSeperateSettings,
        ),
        if (reminders.shabatAndHolidaysCandles)
          ChooseTimeBeforeWidget(
            hoursValue: reminders.beforeShabatAndHolidaysCandlesHours,
            minutesValue: reminders.beforeShabatAndHolidaysCandlesMinutes,
            setHours: reminders.setShabatAndHolidaysCandlesHours,
            setMinutess: reminders.setShabatAndHolidaysCandlesMinutes,
            localizedHelpText:
                appLocalizations.remindMeXhoursAndYMinutesBeforeCandlesLighning,
          ),
        const SizedBox(
          height: 7,
        ),
        const Divider(height: 15, thickness: 1.5, indent: 15, endIndent: 15,),
        const SizedBox(
          height: 7,
        ),
        CuperinoTextCheckSwitch(
          value: reminders.havdalah,
          onChanged: () => reminders.setHavdalah(),
          text: 'הבדלה',
        ),
        
        if (reminders.havdalah)
          ChooseTimeBeforeWidget(
            hoursValue: reminders.afterShabatHavdalahHours,
            minutesValue: reminders.afterShabatHavdalahMinutes,
            setHours: reminders.setAfterShabatHavdalahHours,
            setMinutess: reminders.setAfterShabatHavdalahMinutes,
            localizedHelpText:
                (String hours, String minutes) => 'הזכר לי לעשות הבדלה $hours שעות ו- $minutes דקות אחרי שבת',
          ),
        const SizedBox(
          height: 7,
        ),
        const Divider(height: 15, thickness: 1.5, indent: 15, endIndent: 15,),
        const SizedBox(
          height: 7,
        ),
        CuperinoTextCheckSwitch(
          value: reminders.nerotHanukkah,
          onChanged: () => reminders.setNerotHanukkah(),
          text: 'הדלקת נרות חנוכה',
        ),
        if (!reminders.nerotHanukkah) ...{
          const SizedBox(
            height: 7,
          ),
          const Divider(height: 15, thickness: 1.5),
        },
        if (reminders.nerotHanukkah) ...nerotHanukkahElements(),
        devider,
      ];
    }

    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.settingRemindersMenu),
      body: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CuperinoTextCheckSwitch(
                      value: reminders.shabatAndHolidays,
                      onChanged: () => reminders.setShabatAndHolidays(),
                      text: appLocalizations.beforeShabatAndHolidaysSettengs,
                    ),
                    if (reminders.shabatAndHolidays)...{
                      ...shabatAndHolidaysElements(),
                    }
                    else...{
                        devider
                    },
                    // tefillin - start
                    ChooseTimeInDayWidget(
                      title: appLocalizations.tefillin,
                      subtitle: appLocalizations.remindTeffilinSettingsAt,
                      isExpanded: reminders.tefilin,
                      setIsExpanded: reminders.setTefilin,
                      timeObject: reminders.getTefilinTimeObject,
                      setTime: reminders.setTefilinTime,
                      timeString: reminders.tefilinTime,
                    ),
                    // tefillin - end

                    // rosh hodesh - start
                    ChooseTimeInDayWidget(
                      title: appLocalizations.roshHodesh,
                      subtitle: appLocalizations.remindRoshHodeshSettingsAt,
                      isExpanded: reminders.roshChodesh,
                      setIsExpanded: reminders.setRoshChodesh,
                      timeObject: reminders.getRoshChodeshTimeObject,
                      setTime: reminders.setRoshChodeshTime,
                      timeString: reminders.roshChodeshTime,
                      noteText:
                          appLocalizations.roshHodeshReminderWillBeAdvanced,
                    ),
                    // rosh hodesh - end

                    // sfirat omer - start
                    ChooseTimeInDayWidget(
                      title: 'ספירת העומר',
                      subtitle: 'הזכר לי לברך בספירת העומר בכל יום בשעה ',
                      isExpanded: reminders.sfiratOmer,
                      setIsExpanded: reminders.setSfiratOmer,
                      timeObject: reminders.getSfiratOmerTimeObject,
                      setTime: reminders.setSfiratOmerTime,
                      timeString: reminders.sfiratOmerTime,
                    ),
                    // sfirat omer - end

                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          reminders
                              .setReminders(update: true)
                              .then((value) => setState(() {
                                    _isLoading = false;
                                  }));
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(appLocalizations.updateRemindersTitle))
                  ],
                ),
              ),
            ),
    );
  }
}

class TextCheckBox extends StatelessWidget {
  const TextCheckBox({
    Key? key,
    required this.value,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final String text;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Checkbox(value: value, onChanged: (newValue) => onChanged(newValue)),
          Text(text),
        ],
      ),
    );
  }
}