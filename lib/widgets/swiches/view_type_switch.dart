import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewTypeSwitch extends StatelessWidget {
  ViewTypeSwitch(
      {super.key,
      required this.appLocalizations,
      required this.viewState,
      required this.setViewState});
  AppLocalizations appLocalizations;
  ViewState viewState;
  Function setViewState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              !LanguageChangeProvider.isDirectionRTL(null)
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(50))
                                  : const BorderRadius.only(
                                      topRight: Radius.circular(50)))),
                  backgroundColor: viewState == ViewState.events
                      ? MaterialStatePropertyAll<Color>(
                          Theme.of(context).primaryColor)
                      : MaterialStatePropertyAll<Color>(Colors.blue.shade800),
                ),
                onPressed: viewState != ViewState.events
                    ? () => setViewState(ViewState.events)
                    : null,
                child: FittedBox(
                  child: Text(
                    appLocalizations.weekEvents,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: viewState == ViewState.events
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                )),
          ),
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              LanguageChangeProvider.isDirectionRTL(null)
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(50))
                                  : const BorderRadius.only(
                                      topRight: Radius.circular(50)))),
                  backgroundColor: viewState == ViewState.zmanim
                      ? MaterialStatePropertyAll<Color>(
                          Theme.of(context).primaryColor)
                      : MaterialStatePropertyAll<Color>(Colors.blue.shade800),
                ),
                onPressed: viewState != ViewState.zmanim
                    ? () => setViewState(ViewState.zmanim)
                    : () {},
                child: FittedBox(
                  child: Text(
                    appLocalizations.todayTimes,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: viewState == ViewState.zmanim
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
