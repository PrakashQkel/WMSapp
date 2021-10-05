import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wms_app/pages/loading.dart';
import 'package:wms_app/widgets/appbar_title.dart';
import 'package:wms_app/widgets/connection_page_dropdown_menu.dart';
import 'package:wms_app/widgets/input_textbox.dart';
import 'package:wms_app/widgets/page_title.dart';
import 'package:wms_app/MQTTClientWrapper.dart';
import 'package:provider/provider.dart';


//This is the Connection page
class connection extends StatefulWidget {

  @override
  _connectionState createState() => _connectionState();

}

class _connectionState extends State<connection> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final MQTTState = Provider.of<MQTTManager>(context); //using Provider package to receive the MQTT connection status

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
                        //calling the MQTT connect function when the connect button is pressed
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