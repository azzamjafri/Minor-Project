import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minor_project/Authentication/signup_details.dart';

import 'package:minor_project/Auxiliary/custom_class.dart';

import 'package:minor_project/Services/authentication.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String currentText;

  final key = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Registration variables

  bool valid;

  bool loading = false;
  final auth = FirebaseAuth.instance;

  void submit(
      String email, String password, String phone, BuildContext ctx) async {
    AuthResult authresult;
    try {
      setState(() {
        loading = true;
      });
      authresult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Firestore.instance
          .collection('users')
          .document(authresult.user.uid)
          .setData({
        'email': emailController.text,
        'phone': phoneController.text,
        'name': userNameController.text,
      });
      setState(() {
        loading = false;
        user = authresult.user;
      });

      print(user.uid + user.email + ' ************************ ');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupDetails()));
    } on PlatformException catch (error) {
      var message = ' An error occured, please check credentials';
      if (error.message != null) {
        message = error.message;
      }
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        buttons: [
          DialogButton(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ],
      ).show();
      setState(() {
        loading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        loading = false;
      });
    }
  }

  void trysubmit(BuildContext cont) async {
    valid = formkey.currentState.validate();
    FocusScope.of(cont).unfocus();
    if (valid) {
      formkey.currentState.save();
      submit(emailController.text.trim(), passwordController.text.trim(),
          phoneController.text.trim(), cont);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hit = displayHeight(context);
    double wid = displayWidth(context);

    return SafeArea(
      child: Scaffold(
        key: key,
        body: Center(
          child: Container(
            width: wid,
            color: Color.fromRGBO(241, 243, 241, 1),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  Container(
                      height: 180.0,
                      child: Image.asset(
                        "assets/logo.png",
                      )),
                  Align(
                    alignment: Alignment(0, -1),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: wid * .80,
                          height: 52.0,
                          child: Material(
                            elevation: 5,
                            shape: StadiumBorder(),
                            child: TextFormField(
                              controller: userNameController,
                              enableInteractiveSelection: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Icon(
                                      Icons.person,
                                      size: 35,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                  hintText: "Enter Username"),
                              validator: (value) => value.isEmpty
                                  ? 'Username Cannot be empty'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(13.0)),
                        Container(
                          width: wid * .8,
                          height: 52.0,
                          child: Material(
                            elevation: 5,
                            shape: StadiumBorder(),
                            child: TextFormField(
                              controller: phoneController,
                              enableInteractiveSelection: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Icon(
                                      Icons.phone,
                                      size: 35,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                  hintText: "Enter Phone Number"),
                              keyboardType: TextInputType.number,
                              validator: (value) => value.length < 10
                                  ? 'Enter a valid phone number'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(13.0)),
                        Container(
                          width: wid * .8,
                          height: 52.0,
                          child: Material(
                            elevation: 5,
                            shape: StadiumBorder(),
                            child: TextFormField(
                              controller: emailController,
                              enableInteractiveSelection: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Icon(
                                      Icons.email,
                                      size: 35,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                  hintText: "Enter Email"),
                              validator: (value) => value.isEmpty
                                  ? 'Email can not be empty'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(13.0)),
                        Container(
                          width: wid * .8,
                          height: 52.0,
                          child: Material(
                            elevation: 5,
                            shape: StadiumBorder(),
                            child: TextFormField(
                              controller: passwordController,
                              enableInteractiveSelection: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Icon(
                                      Icons.lock,
                                      size: 35,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                  hintText: "Enter Password"),
                              obscureText: true,
                              validator: (value) => value.length < 8
                                  ? 'Password must be 8 characters long'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(13.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width: wid * .7,
                            child: RaisedButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black)),
                                elevation: 5.0,
                                onPressed: () {
                                  trysubmit(context);
                                },
                                child: (loading)
                                    ? CircularProgressIndicator()
                                    : Text("Continue",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 26.0,
                                            letterSpacing: 2.0)))),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
