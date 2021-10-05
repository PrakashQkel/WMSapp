import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/models/user.dart';
import 'package:wms_app/pages/page_wrapper.dart';
import 'authentication/authenticate.dart';

//this class displays the SignIn-Register section and the Connection-Subscription-Display section according to the authentication status
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FUser?>(context); //using the Provider package to receive authentication status

    if(user == null){ //if not authenticated
      return Authenticate();
    }
    else{ //if successfully authenticated
      return PageWrapper();
    }
  }
}
