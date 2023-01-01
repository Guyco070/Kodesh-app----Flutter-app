import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';

class CustomExpandedListView extends StatefulWidget {
  const CustomExpandedListView(
      {super.key,
      required this.children,
      this.maxHeight = 300,
      this.minHeight = 140,
      this.titledExpandIcon});
  final List<Widget> children;
  final double minHeight;
  final double maxHeight;
  final Widget? titledExpandIcon;
  @override
  State<CustomExpandedListView> createState() => _CutomExpandedListViewState();
}

class _CutomExpandedListViewState extends State<CustomExpandedListView> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    var iconButton = ExpandIcon(
            isExpanded: _isExpanded,
            onPressed: (isExp) {
              setState(() {
                _isExpanded = !isExp;
              });
            },
           );
    return Column(
      children: [
        if(widget.titledExpandIcon != null) ...{
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(alignment: !LanguageChangeProvider.isDirectionRTL(null) ? Alignment.centerLeft : Alignment.centerRight, child: const SizedBox(width: 40,)), // set title centered
              Align(alignment: Alignment.center, child: widget.titledExpandIcon!),
              Align(alignment: LanguageChangeProvider.isDirectionRTL(null) ? Alignment.centerLeft : Alignment.centerRight, child: iconButton),
            ],
          ),
          const Divider(
            indent: 18,
            endIndent: 18,
          ),
        },
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(0),
                Colors.black
                    .withOpacity(0.1), //This controls the darkness of the bar
              ],
              // stops: [0, 1], if you want to adjust the gradiet this is where you would do it
            ),
          ),
          child: LimitedBox(
            maxHeight: _isExpanded ? widget.maxHeight : widget.minHeight,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: widget.children,
            ),
          ),
        ),
        if(widget.titledExpandIcon == null) iconButton
      ],
    );
  }
}
