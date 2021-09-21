import 'dart:ui';
import 'package:flutter/material.dart';


class AppbarTitle extends StatelessWidget {
  const AppbarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      'Water Management System',
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}
