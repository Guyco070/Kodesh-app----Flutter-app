import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/Shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/havdalah.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/custom_expanded_list_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              title: appLocalizations.menu,
              // automaticallyImplyLeading: false, // No back button
              // actions: [
              //   IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_left_outlined))
              // ],
            ),

            ...devidedTitle(appLocalizations.settings),
            
            ListTile(
              leading: const Icon(Icons.watch_later_outlined),
              title: Text(appLocalizations.settingRemindersMenu),
              onTap: () => Navigator.pushNamed(
                  context, SchedualNotficationsScreen.routeName),
            ),

            ...devidedTitle(appLocalizations.aids),
            
            ListTile(
              leading: const Icon(Icons.checklist_rtl),
              title: Text(appLocalizations.choresBeforeShabbatMenu),
              onTap: () => Navigator.pushNamed(
                  context, ShabatAndHolidaysCheckList.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.compass_calibration_outlined),
              title: Text(appLocalizations.compass),
              onTap: () =>
                  Navigator.pushNamed(context, CompassScreen.routeName),
            ),
            
            CustomExpandedListView(
              titledExpandIcon: title(appLocalizations.prayersAndBlessings),
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.fireplace_outlined,
                  ),
                  title: Text(appLocalizations.candleLightingOrderMenu),
                  onTap: () => Navigator.pushNamed(
                      context, AdlakatNerot.routeName),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.wine_bar,
                  ),
                  title: Text(appLocalizations.havdalah),
                  onTap: () =>
                      Navigator.pushNamed(context, Havdalah.routeName),
                ),
                ListTile(
                  leading: const Icon(Icons.add_reaction_outlined),
                  title: Text(appLocalizations.tefilinOrderMenu),
                  onTap: () => Navigator.pushNamed(
                      context, SederAnahatTefilin.routeName),
                ),
                ListTile(
                  leading: const Icon(Icons.fireplace),
                  title: Text(
                    appLocalizations.hanukkahCandleLightingOrderMenu,
                  ),
                  onTap: () => Navigator.pushNamed(
                      context, AdlakatNerotChanukah.routeName),
                ),
                ListTile(
                  leading: const Icon(Icons.content_cut),
                  title: Text(appLocalizations.sederSfiratOmer),
                  onTap: () => Navigator.pushNamed(
                      context, SfiratOmerScreen.routeName),
                ),
              ],
            ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.edit),
            //   title: const Text('Manage Products'),
            //   onTap: () => Navigator.pushReplacementNamed(
            //       context, UserProductsScreen.routeName),
            // ),
            // const Divider(),
            // ListTile(
            //     leading: const Icon(Icons.exit_to_app),
            //     title: const Text('Logout'),
            //     onTap: () {
            //       Navigator.of(context).pop();
            //       Navigator.of(context).pushReplacementNamed('/');
            //       Provider.of<Auth>(context, listen: false).logout();
            //     }),
          ],
        ),
      ),
    );
  }

  Text title(String title) => Text(
        title,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      );

  List<Widget> devidedTitle(String title) => [
        const Divider(),
        Text(
          title,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const Divider(
          indent: 18,
          endIndent: 18,
        ),
      ];
}
