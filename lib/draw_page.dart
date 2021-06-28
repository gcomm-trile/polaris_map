import 'dart:math';

import 'package:flutter/material.dart';

extension NumberUtil on num {
  num toRadian() {
    return this * pi / 180;
  }
}

class DrawPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ClipPath(
          clipper: MyClipper(),
          child: Container(
            width: double.infinity,
            color: Colors.red,
            height: 300,
            child: Center(child: Text('EZ')),
          ),
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - 150, size.width, size.height - 50)
      // ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      // ..lineTo(0, size.height)
      // ..quadraticBezierTo(size.width / 2, size.height - 100, size.width, 0)
      // ..lineTo(size.width, size.height)
      // ..lineTo(size.width, 0)
      // ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
