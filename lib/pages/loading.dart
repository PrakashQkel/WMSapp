import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//this is just the loading screen that is displayed while is app is doing some stuff that takes some time
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: SpinKitRipple(
          color: Colors.blue,
          size: 300,
        ),
      ),
    );
  }
}
