import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/models/user.dart';
import 'package:wms_app/services/auth_service.dart';

class ConnectionPageMenu extends StatelessWidget {
  const ConnectionPageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                    Icons.person
                ),
                title: Text(
                    'Sign Out'
                ),
                onTap: () async{
                  await auth.signOut(); //signing out
                  Navigator.pop(context); //close the menu upon clicking an option
                },
              )
          ),
        ]
    );
  }
}

