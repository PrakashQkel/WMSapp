import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/pages/connection/connection_page.dart';
import 'package:wms_app/pages/display/display_page.dart';
import 'package:wms_app/pages/subscription/subscription_page.dart';
import '../MQTTClientWrapper.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<MQTTManager>(context);

    if(appState.appState==MqttAppState.connecting){
      Future.delayed(Duration(milliseconds: 100), (){
        appState.previousState = MqttAppState.connecting;
        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connecting...', textAlign: TextAlign.center,)));
      }
      );
    }
    Future.delayed(Duration(milliseconds: 100), (){
      if(appState.appState==MqttAppState.disconnected && appState.previousState==MqttAppState.connecting) {
        appState.previousState = MqttAppState.disconnected;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Connection unsuccessful!', textAlign: TextAlign.center,)));
      }
    });

    if(appState.appState==MqttAppState.connected){
      Future.delayed(Duration(milliseconds: 100), (){
        appState.previousState = MqttAppState.connected;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Connected to Broker "${appState.broker}"', textAlign: TextAlign.center,)));
      }
      );
    }

    if(appState.appState==MqttAppState.subscribed && appState.previousState!=MqttAppState.subscribed){
      Future.delayed(Duration(milliseconds: 100), (){
        appState.previousState = MqttAppState.subscribed;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Subscribed to Topic "${appState.topic}"', textAlign: TextAlign.center,)));
      }
      );
    }

    if(appState.appState==MqttAppState.disconnected && appState.previousState!=MqttAppState.disconnected){
      Future.delayed(Duration(milliseconds: 100), (){
        appState.previousState = MqttAppState.disconnected;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Disconnected', textAlign: TextAlign.center,)));
      }
      );
    }

    //displaying page according to the connection state
    if(appState.appState == MqttAppState.connected) {
      return subscription();
    }
    else if(appState.appState == MqttAppState.subscribed) {
      return display();
    }
    else//(MQTTState.appState == MqttAppState.disconnected && MQTTState.currentPage!='Connection_page')
      return connection();
  }
}
