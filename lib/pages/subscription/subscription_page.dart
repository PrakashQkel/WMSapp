import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/MQTTClientWrapper.dart';
import 'package:wms_app/pages/loading.dart';
import 'package:wms_app/widgets/appbar_title.dart';
import 'package:wms_app/widgets/input_textbox.dart';
import 'package:wms_app/widgets/subscription_page_dropdown_menu.dart';
import 'package:wms_app/widgets/page_title.dart';

//This is the subscription page similar to connection page
class subscription extends StatefulWidget {
  const subscription({Key? key}) : super(key: key);

  @override
  _subscriptionState createState() => _subscriptionState();
}

class _subscriptionState extends State<subscription> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final MQTTState = Provider.of<MQTTManager>(context);

    return loading ? Loading() : Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: AppbarTitle(),
            actions: [
              SubscriptionPageMenu()
            ],
            backgroundColor: Colors.blue[500],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageTitle('Subscription'),
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputTextBox('Topic', false)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    icon: Icon(Icons.add_circle_outlined, size: 35,),
                    label: Text(
                      'Subscribe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      //calling the MQTT subscribe function when the subscribe button is pressed
                      MQTTState.subscribe();
                    }
                  ),
                )
              ],
            ),
          )
      );
  }
}
