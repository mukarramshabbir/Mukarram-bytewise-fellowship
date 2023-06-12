import 'package:flutter/material.dart';

class Titlee extends StatelessWidget {
  const Titlee({
    Key? key,
    required this.text,
    required this.width,
  }) : super(key: key);

  final double width;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: width * 0.04,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
