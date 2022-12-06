import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/Shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:kodesh_app/screens/tpilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tpilot/seder_anahat_tefilin.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('שבת שלום'),
            automaticallyImplyLeading: false, // No back button
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_right_outlined))
            ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: const Text('קביעת תזכורות'),
            onTap: () => Navigator.pushNamed(context, SchedualNotficationsScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.fireplace_outlined),
            title: const Text('סדר הדלקת נרות'),
            onTap: () => Navigator.pushNamed(context, AdlakatNerot.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.add_reaction_outlined),
            title: const Text('סדר הנחת תפילין'),
            onTap: () => Navigator.pushNamed(context, SederAnahatTefilin.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.checklist_rtl),
            title: const Text('מטלות לפני שבת'),
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