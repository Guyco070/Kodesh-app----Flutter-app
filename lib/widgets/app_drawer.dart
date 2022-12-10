import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/Shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:kodesh_app/screens/tfilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tfilot/seder_anahat_tefilin.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Drawer(
      child: Column(
        children: [
          CustomAppBar(
            title: appLocalizations.menu,
            // automaticallyImplyLeading: false, // No back button
            // actions: [
            //   IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_left_outlined))
            // ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: Text(appLocalizations.settingRemindersMenu),
            onTap: () => Navigator.pushNamed(context, SchedualNotficationsScreen.routeName),
          ),
          const Divider(),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.checklist_rtl),
            title: Text(appLocalizations.choresBeforeShabbatMenu),
            onTap: () => Navigator.pushNamed(context, ShabatAndHolidaysCheckList.routeName),
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
    );
  }
}