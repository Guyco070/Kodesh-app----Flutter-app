import 'package:flutter/cupertino.dart';

class AnimatedLongText extends StatefulWidget {
  const AnimatedLongText(this.text, {super.key});
  final String text;

  @override
  State<AnimatedLongText> createState() => _AnimatedLongTextState();
}

class _AnimatedLongTextState extends State<AnimatedLongText> {
  int _charToView = 30;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        _charToView =
            _charToView != widget.text.length ? widget.text.length : 30;
      }),
      child: TweenAnimationBuilder<int>(
        tween: IntTween(begin: 0, end: widget.text.length > _charToView + 5 ? _charToView : widget.text.length),
        duration: Duration(seconds: ((widget.text.length > _charToView ? _charToView : widget.text.length) * (1/25)).toInt()),
        builder: (context, value, _) => Text(
          value <= _charToView && value != widget.text.length
              ? '${widget.text.substring(0, value)}...'
              : value < widget.text.length ? '${widget.text.substring(0, value)}_' : widget.text.substring(0, value),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
