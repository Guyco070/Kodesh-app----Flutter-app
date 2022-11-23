import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:provider/provider.dart';

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
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('קביעת תזכורות'),
            onTap: () => Navigator.pushNamed(context, SchedualNotficationsScreen.routeName),
          ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.payment),
          //   title: const Text('Orders'),
          //   onTap: () => Navigator.pushNamed(context, OrdersScreen.routeName),
          //   // onTap: () => Navigator.pushReplacement(context, CustomRoute(builder: ((context) => const OrdersScreen()))),
          // ),
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