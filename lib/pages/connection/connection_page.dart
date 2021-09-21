import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wms_app/pages/loading.dart';
import 'package:wms_app/widgets/appbar_title.dart';
import 'package:wms_app/widgets/connection_page_dropdown_menu.dart';
import 'package:wms_app/widgets/input_textbox.dart';
import 'package:wms_app/widgets/page_title.dart';
import 'package:wms_app/MQTTClientWrapper.dart';
import 'package:provider/provider.dart';

class connection extends StatefulWidget {
  //const connection({Key? key}) : super(key: key);

  @override
  _connectionState createState() => _connectionState();
}

class _connectionState extends State<connection> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final MQTTState = Provider.of<MQTTManager>(context);

    if(MQTTState.appState == MqttAppState.disconnected){
      setState(() {
        loading = false;
      });
    }

    return loading ? Loading(): Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: AppbarTitle(),
              actions: [
                ConnectionPageMenu()
              ],
              backgroundColor: Colors.blue[500],
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageTitle('Connection'),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputTextBox('Broker', false),
                        InputTextBox('Port', true),
                        InputTextBox('Client ID', false)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                      icon: Icon(Icons.refresh, size: 35,),
                      label: Text(
                        "Connect",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: (){
                        setState(() {
                          loading = true;
                        });
                          MQTTState.initializeClient();
                          MQTTState.connect();
                      },
                    ),
                  )
                ],
              ),
            )
        );
  }
}

/*
class connection_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

      */
/*final appState = Provider.of<MQTTManager>(context);*//*


      //displaying messages
      */
/*if(appState.appState==MqttAppState.connecting){
        Future.delayed(Duration(milliseconds: 100), (){
          appState.previousState = MqttAppState.connecting;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connecting...', textAlign: TextAlign.center,)));
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
      }*//*


      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PageTitle('Connection'),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputTextBox('Broker', false),
                  InputTextBox('Port', true),
                  InputTextBox('Client ID', false)
                ],
              ),
            ),
            InputButton('Connect', true),
          ],
        ),
      );
  }
}
*/

