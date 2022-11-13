import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     _isLoading = true;
  //     Provider.of<Events>(context, listen: false)
  //         .fetchAndSetProducts()
  //         .then((_) => setState(() {
  //               _isLoading = false;
  //             }));
  //   }
  //   setState(() {
  //     _isInit = false;
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'שבת',
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(onPressed: (){

        //   }, icon: const Icon(Icons.menu))
        // ]
      ),
      body: FutureBuilder(
          future: Provider.of<Events>(context).fetchAndSetProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
              var events = Provider.of<Events>(context, listen: false);
                
              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          itemBuilder: (context) {
                            return cities.split('\n').map((element) {
                              return PopupMenuItem(
                                value: element,
                                child: Text(element.split('|')[0]),
                              );
                            }).toList();
                          },
                          onSelected: (value) {
                            events.setCity(value);
                          },
                        ),
                        Text(events.city.split('|')[0]),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        DateFormat('HH:mm')
                            .format(snapshot.data!.entryDate!),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: const Text(
                        'כניסה והדלקת נרות',
                        textAlign: TextAlign.right,
                      ),
                      leading: Text(DateFormat('dd/MM/yyyy')
                          .format(snapshot.data!.entryDate!)),
                      trailing: const Icon(Icons.fireplace_outlined),
                    ),
                    ListTile(
                      title: Text(
                        DateFormat('HH:mm')
                            .format(snapshot.data!.releaseDate!),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: const Text(
                        'יציאה והבדלה',
                        textAlign: TextAlign.right,
                      ),
                      leading: Text(DateFormat('dd/MM/yyyy')
                          .format(snapshot.data!.releaseDate!)),
                      trailing: const Icon(Icons.wine_bar),
                    ),
                    ListTile(
                      title: Text(
                        snapshot.data!.parasha!,
                        textAlign: TextAlign.right,
                      ),
                      subtitle: const Text(
                        'פרשת שבוע',
                        textAlign: TextAlign.right,
                      ),
                      trailing: const Icon(Icons.book_outlined),
                    )
                  ],
                ),
              );
      }),
      persistentFooterAlignment: AlignmentDirectional.topCenter,
    );
  }
}
