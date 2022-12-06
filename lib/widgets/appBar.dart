import 'package:flutter/material.dart';

AppBar getRightBackAppBar(BuildContext context, String title) => AppBar(
      title: Text(title),
      centerTitle: true,
      automaticallyImplyLeading: false, // No back button
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_right_outlined))
      ],
    );
