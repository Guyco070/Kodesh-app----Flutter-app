import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CuperinoTextCheckSwitch extends StatelessWidget {
  const CuperinoTextCheckSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  final bool value;
  final Function onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        CupertinoSwitch(
            activeColor: Theme.of(context).primaryColor,
            value: value,
            onChanged: (_) => onChanged()),
      ],
    );
  }
}