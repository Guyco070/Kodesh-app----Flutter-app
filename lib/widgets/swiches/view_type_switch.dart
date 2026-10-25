import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/swiches/view_type_switch/view_type_tab.dart';

class ViewTypeSwitch extends StatelessWidget {
  const ViewTypeSwitch({
    super.key,
    required this.appLocalizations,
    required this.viewState,
    required this.setViewState,
  });
  final AppLocalizations appLocalizations;
  final ViewState viewState;
  final Function setViewState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Expanded(
            child: ViewTypeTab(
              label: appLocalizations.weekEvents,
              selected: viewState == ViewState.events,
              roundedStart: true,
              onSelected: () => setViewState(ViewState.events),
            ),
          ),
          Expanded(
            child: ViewTypeTab(
              label: appLocalizations.todayTimes,
              selected: viewState == ViewState.zmanim,
              roundedStart: false,
              onSelected: () => setViewState(ViewState.zmanim),
            ),
          ),
        ],
      ),
    );
  }
}
