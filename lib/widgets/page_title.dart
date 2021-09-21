import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {

  final String title;
  PageTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        //height: 140,
        padding: EdgeInsets.all(50),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }
}

