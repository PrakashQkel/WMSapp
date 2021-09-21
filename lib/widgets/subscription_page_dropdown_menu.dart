import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/MQTTClientWrapper.dart';
import 'package:wms_app/pages/connection/connection_page.dart';
import 'package:wms_app/services/auth_service.dart';

class SubscriptionPageMenu extends StatelessWidget {
  const SubscriptionPageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final MQTTState = Provider.of<MQTTManager>(context);
    final auth = AuthService();

    return PopupMenuButton(
        icon: Icon(
          Icons.view_headline_rounded,
          color: Colors.white,
          size: 30,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
              child: ListTile(
                minLeadingWidth: 0,
                trailing: null,
                leading: Icon(
                    Icons.account_tree_sharp
                ),
                title: Text(
                    'About us'
                ),
              )
          ),
          PopupMenuItem(
              child: ListTile(
                minLeadingWidth: 0,
                trailing: null,
                leading: Icon(
                    Icons.star
                ),
                title: Text(
                    'Rate us'
                ),
              )
          ),
          PopupMenuItem(
              child: ListTile(
                minLeadingWidth: 0,
                trailing: null,
                leading: Icon(
                    Icons.feedback_rounded
                ),
                title: Text(
                    'Feedback'
                ),
              )
          ),
          PopupMenuItem(
              child: ListTile(
                  minLeadingWidth: 0,
                  trailing: null,
                  leading: Icon(
                      Icons.cancel
                  ),
                  title: Text(
                    'Disconnect',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                      'broker: '+MQTTState.broker
                  ),
                  onTap: () {
                    MQTTState.disconnect();
                    Navigator.pop(context);
                  }
              )
          ),
          PopupMenuItem(
              child: ListTile(
                minLeadingWidth: 0,
                trailing: null,
                leading: Icon(
                    Icons.person
                ),
                title: Text(
                    'Sign Out'
                ),
                onTap: () async{
                  Navigator.pop(context);//close the menu upon clicking an option
                  await auth.signOut();
                },
              )
          ),
        ]
    );
  }
}


