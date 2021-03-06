import 'package:flutter/material.dart';
import 'package:wms_app/pages/loading.dart';
import 'package:wms_app/services/auth_service.dart';
import 'package:wms_app/widgets/appbar_title.dart';
import 'package:wms_app/widgets/page_title.dart';

//this is the SignIn page
class SignIn extends StatefulWidget {

  final Function toggleSignInAndRegister;

  SignIn({required this.toggleSignInAndRegister});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  late String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    //initializing some variables
    final auth = AuthService();
    final emailController = TextEditingController();
    final pwdController = TextEditingController();

    return loading ? Loading() : Scaffold( //for displaying the loading screen while it's signing in
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitle(),
        backgroundColor: Colors.blue[500],
        actions: [
          IconButton( //the button to switch to Register page
              onPressed: (){
                widget.toggleSignInAndRegister();
              },
              icon: Icon(Icons.person_add_alt_1)
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
                PageTitle('Sign In'),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(
                      width: 250,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(  //TextField to enter Email
                        validator: (val) => val!.isEmpty ? 'Enter Email!' : null,
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
                        child: TextFormField(  //TextField to enter Password
                          validator: (val) => val!.isEmpty ? 'Enter password!' : null,
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
                      Text(error, style: TextStyle(color: Colors.red),) //Displaying the error
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  child: ElevatedButton.icon( //SignIn button
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    icon: Icon(Icons.person, size: 35,),
                    label: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async{
                      if(formKey.currentState!.validate()) { //if the form validation is successful i.e., email and password are entered
                        setState(() {
                          loading = true; //triggers the loading screen
                        });
                        //calling the SignIn function
                        dynamic result = await auth.signInWithEmailAndPassword(emailController.text, pwdController.text);
                        //if SignIn is unsuccessful
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Invalid email or password!';
                          });
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
