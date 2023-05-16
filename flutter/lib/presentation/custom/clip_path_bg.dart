import 'package:flutter/material.dart';

import '../theme/color.dart';

class ClipPathBackground extends StatelessWidget {
  final double height;
  const ClipPathBackground({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomClipper(),
          child: Container(
            height: height,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 6, 89, 214),
                  Color.fromARGB(255, 8, 106, 252),
                  Color.fromARGB(255, 8, 106, 252),
                  Color.fromARGB(255, 139, 6, 172)
                ],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: TopClipper(),
          child: Container(
            height: height,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  secondary,
                  tertiary,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomHomeContainer extends StatelessWidget {
  final double height;
  const CustomHomeContainer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [
            primary,
            secondary,
            tertiary,
          ],
        ),
      ),
      height: height,
      width: double.infinity,
    );
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    var path = Path();

    path.lineTo(0, h);

    var firstStart = Offset(w / 5, h);
    var firstEnd = Offset(w / 2.25, h - 60.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(w - (w / 3.20) + 2, h - 150);
    var secondEnd = Offset(w, h - 50);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    var path = Path();

    path.lineTo(0, h);
    var firstStart = Offset(w / 5, h);
    var firstEnd = Offset(w / 2.25, h - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(w - (w / 3.20) + 2, h - 105);
    var secondEnd = Offset(w, h - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
