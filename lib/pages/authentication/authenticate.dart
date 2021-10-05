import 'package:flutter/material.dart';
import 'package:wms_app/pages/authentication/register.dart';
import 'package:wms_app/pages/authentication/sign_in.dart';


//this class toggles between the SignIn and Register pages
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;

  void toggleSignInAndRegister(){
    setState(() {
      signIn = !signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    //toggle between sign in and register
    if(signIn == true)
      return SignIn(toggleSignInAndRegister: toggleSignInAndRegister);
    else {
      return Register(toggleSignInAndRegister: toggleSignInAndRegister);
    }
  }
}
