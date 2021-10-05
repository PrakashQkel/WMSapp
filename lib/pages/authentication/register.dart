import 'package:flutter/material.dart';
import 'package:wms_app/pages/loading.dart';
import 'package:wms_app/services/auth_service.dart';
import 'package:wms_app/widgets/appbar_title.dart';
import 'package:wms_app/widgets/page_title.dart';


//this is the Register page, similar to SignIn page
class Register extends StatefulWidget {

  final Function toggleSignInAndRegister;

  Register({required this.toggleSignInAndRegister});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final formKey = GlobalKey<FormState>();
  late String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final auth = AuthService();
    final emailController = TextEditingController();
    final pwdController = TextEditingController();

    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitle(),
        backgroundColor: Colors.blue[500],
        actions: [
          IconButton(
            onPressed: (){
              widget.toggleSignInAndRegister();
            },
            icon: Icon(
              Icons.person,
            ),
          )
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageTitle('Register'),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            validator: (val) => val!.isEmpty ? 'Enter an Email!' : null,
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            validator: (val) => val!.length < 8 ? 'Password must contain at least 8 characters!' : null,
                            controller: pwdController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                      icon: Icon(Icons.person_add_alt_1, size: 35,),
                      label: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async{
                        if(formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          //the only difference from SignIn page is that we call the Register function instead of SignIn function
                          dynamic result = await auth.registerWithEmailAndPassword(emailController.text, pwdController.text);
                          if(result == null) {
                            setState(() {
                              loading = false;
                              error = 'Enter a valid Email!';
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
