import 'package:flutter/material.dart';

class ThingToRemind extends StatefulWidget {
  final String title;
  final IconData icon;

  const ThingToRemind({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  State<ThingToRemind> createState() => _ThingToRemindState();
}

class _ThingToRemindState extends State<ThingToRemind> {
  bool isChecked = false;

  setIsCheck() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // When the user taps the button, show a snackbar.
        onTap: () {
          setIsCheck();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: isChecked ? Colors.grey[900] : Colors.grey[200],
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey, width: 2)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      isChecked
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 30,
                            )
                          : const Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: 30,
                            ),
                      Expanded(
                          child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: isChecked ? Colors.white : Colors.black,
                        ),
                      )),
                    ],
                  ),
                ),
                Icon(
                  widget.icon,
                  size: 50,
                  color: isChecked ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
        ));
  }
}
