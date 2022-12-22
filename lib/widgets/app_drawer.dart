import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/Shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:kodesh_app/screens/tfilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tfilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tfilot/seder_anahat_tefilin.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kodesh_app/screens/tfilot/sfirat_omer_screen.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';

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
            title(appLocalizations.settings),
            const Divider(indent: 18, endIndent: 18,),
            ListTile(
              leading: const Icon(Icons.watch_later_outlined),
              title: Text(appLocalizations.settingRemindersMenu),
              onTap: () => Navigator.pushNamed(context, SchedualNotficationsScreen.routeName),
            ),
            const Divider(),
            title(appLocalizations.prayersAndBlessings),
            const Divider(indent: 18, endIndent: 18,),
            ListTile(
              leading: const Icon(Icons.fireplace_outlined,),
              title: Text(appLocalizations.candleLightingOrderMenu),
              onTap: () => Navigator.pushNamed(context, AdlakatNerot.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.add_reaction_outlined),
              title: Text(appLocalizations.tefilinOrderMenu),
              onTap: () => Navigator.pushNamed(context, SederAnahatTefilin.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.fireplace),
              title: Text(appLocalizations.hanukkahCandleLightingOrderMenu,),
              onTap: () => Navigator.pushNamed(context, AdlakatNerotChanukah.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.content_cut),
              title: Text(appLocalizations.sederSfiratOmer),
              onTap: () => Navigator.pushNamed(context, SfiratOmerScreen.routeName),
            ),
            const Divider(),
            title(appLocalizations.aids),
            const Divider(indent: 18, endIndent: 18,),
            ListTile(
              leading: const Icon(Icons.checklist_rtl),
              title: Text(appLocalizations.choresBeforeShabbatMenu),
              onTap: () => Navigator.pushNamed(context, ShabatAndHolidaysCheckList.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.compass_calibration_outlined),
              title: Text(appLocalizations.compass),
              onTap: () => Navigator.pushNamed(context, CompassScreen.routeName),
            ),
            const Divider(),
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

  Text title(String title) => Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12),);
}