import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:provider/provider.dart';

class TefilaWidget extends StatelessWidget {
  const TefilaWidget({
    Key? key,
    required this.getBracha,
    this.imagePath,
    this.imageExtaLine,
    this.isWithNosah = true,
  }) : super(key: key);

  final Map<String, Map<Nosah, List<String>>> getBracha;
  final String? imagePath;
  final String? imageExtaLine;
  final bool isWithNosah;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(children: [
          if (imagePath != null)
            ClipPath(
                // borderRadius: BorderRadius.circular(200),
                clipper: MyCustomClipper(),
                child: Image.asset(
                  imagePath!,
                )),
          if (imageExtaLine != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                imageExtaLine!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.grey.shade600),
              ),
            ),
          if (isWithNosah)
            Provider.of<Tfilot>(context).getNosahim(context, getBracha),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                TextSpan(
                    children: Provider.of<Tfilot>(context, listen: false)
                        .getSederWidgets(getBracha, isWithNosah))),
          )
        ]),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  Path _getCurvedPath(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, h-50); // line down from 0 to h - 50
    path.quadraticBezierTo(
      w * 0.5, // to start curve in the middle of the path 
      h + 50, // h value at w * 0.5
      w, // w at the end of curve
      h - 50 // h value at w = w
    );
    path.lineTo(w, 0); // line up from w to 0
    return path;
  }

  @override
  getClip(Size size) {
    return _getCurvedPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
