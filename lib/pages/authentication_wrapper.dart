import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/models/user.dart';
import 'package:wms_app/pages/connection/connection_page.dart';
import 'package:wms_app/pages/page_wrapper.dart';
import 'authentication/authenticate.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FUser?>(context);

    if(user == null){
      return Authenticate();
    }
    else{
      return PageWrapper();
    }
  }
}
