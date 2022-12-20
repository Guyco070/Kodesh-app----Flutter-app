import 'package:flutter/cupertino.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';

class AnimatedFromNowOnTimesListView extends StatefulWidget {
  AnimatedFromNowOnTimesListView({super.key, required this.widgets});
  List<Widget> widgets = [];

  @override
  State<AnimatedFromNowOnTimesListView> createState() =>
      _AnimatedFromNowOnTimesListViewState();
}

class _AnimatedFromNowOnTimesListViewState
    extends State<AnimatedFromNowOnTimesListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Widget> _list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _addWidgets());
  }

  void _addWidgets() {
    Future ft = Future(() {});
    widget.widgets.forEach((Widget element) {
      ft = ft.then((_) => Future.delayed(const Duration(milliseconds: 50,), (){
        _list.add(element);
        if(_listKey.currentState != null) {
          _listKey.currentState!.insertItem(_list.length - 1);
        }
      }));
    });
  }

  final Tween<Offset> _offset = Tween(
      begin: Offset(LanguageChangeProvider.isDirectionRTL(null) ? -1 : 1, 0),
      end: const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      key: _listKey,
      initialItemCount: _list.length,
      itemBuilder: ((context, index, animation) => SlideTransition(
            position: animation.drive(_offset),
            child: _list[index],
          )),
    );
  }
}
