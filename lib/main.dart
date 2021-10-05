import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wms_app/pages/authentication_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/services/auth_service.dart';
import 'MQTTClientWrapper.dart';
import 'models/user.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  //initializing Firebase

  runApp(
      MyApp() //running the app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamProvider<FUser?>.value( //Using Provider package to receive the user authentication status from Firebase
      initialData: null,
      value: AuthService().userState,  //the exact value that is received
      child: ChangeNotifierProvider<MQTTManager>( //Using Provider package to receive the MQTT connection status from MQTTClientWrapper.dart
        create: (context)=>MQTTManager(),
        child:MaterialApp(
          home: AuthenticationWrapper()
        )
      ),
    );
  }
}


