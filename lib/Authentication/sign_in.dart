import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minor_project/Authentication/sign_up.dart';
import 'package:minor_project/Auxiliary/custom_class.dart';
import 'package:minor_project/Home/home.dart';
import 'package:minor_project/Services/authentication.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String currentText;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final key = new GlobalKey<ScaffoldState>();

  AuthResult authresult;
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool valid;

  void submit(String email, String password, BuildContext ctx) async {
    try {
      setState(() {
        loading = true;
      });

      authresult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      setState(() {
        loading = false;
      });
      user = authresult.user;
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
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
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            color: Colors.white,
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

  void reset() async {
    auth.sendPasswordResetEmail(email: emailController.text.trim());
  }

  void trysubmit(BuildContext context) async {
    valid = formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (valid) {
      formkey.currentState.save();
      submit(
          emailController.text.trim(), passwordController.text.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double hit = displayHeight(context);
    double wid = displayWidth(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: key,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: 220,
                    child: Image.asset(
                      "assets/logo.png",
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: wid * .8,
                    child: Material(
                      elevation: 5,
                      shape: StadiumBorder(),
                      child: TextFormField(
                        // key: __passwordkey,
                        controller: emailController,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Icon(
                                Icons.phone,
                                size: 35,
                                color: Colors.black.withOpacity(.75),
                              ),
                            ),
                            hintText: "Enter Email Address"),

                        validator: (value) => value.isEmpty
                            ? 'Enter a valid email address'
                            : null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: wid * .8,
                    child: Material(
                      elevation: 5,
                      shape: StadiumBorder(),
                      child: TextFormField(
                        // key: __passwordkey,
                        controller: passwordController,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Icon(
                                Icons.lock,
                                size: 35,
                                color: Colors.black.withOpacity(.75),
                              ),
                            ),
                            hintText: "Enter Password"),
                        keyboardType: TextInputType.number,
                        validator: (value) => value.length < 8
                            ? 'Password must be 8 characters long'
                            : null,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: wid * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showDialog(context);
                          },
                          child: Text("Forget Password ?"))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 43,
                    width: wid * .5,
                    child: FlatButton(
                        onPressed: () {
                          trysubmit(context);
                        },
                        child: (loading)
                            ? CircularProgressIndicator()
                            : Text("Log in",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  letterSpacing: 2.0,
                                )))),
                Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: (displayWidth(context) / 2) - 35,
                        child: Divider(
                          thickness: 2.0,
                        )),
                    Text('OR'),
                    Container(
                        width: (displayWidth(context) / 2) - 35,
                        child: Divider(
                          thickness: 2.0,
                        )),
                  ],
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/p.png'),
                              fit: BoxFit.fitHeight),
                        ),
                        child: Align(
                            alignment: Alignment(0.3, -.15),
                            child: Text(
                              "Signin",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Container(
                        height: 27,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 18.0),
                                    children: [
                                  TextSpan(text: "Don\'t have an Account? "),
                                  TextSpan(
                                      text: "Register",
                                      style:
                                          TextStyle(color: Colors.blueAccent))
                                ])))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 300,
            child: SizedBox.expand(
                child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Confirm Password Reset ?"),
                        Padding(padding: EdgeInsets.all(22.0)),
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Material(
                            elevation: 5,
                            shape: StadiumBorder(),
                            child: TextFormField(
                              // key: __passwordkey,
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
                                  hintText: "Enter Email Address"),

                              validator: (value) => value.isEmpty
                                  ? 'Enter a valid email address'
                                  : null,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            height: 40,
                            width: 150,
                            child: FlatButton(
                                onPressed: () {
                                  reset();

                                  Future.delayed(const Duration(seconds: 12),
                                      () {
                                    CustomDialog();
                                  });

                                  // Navigator.pop(context);
                                },
                                child: Text("Reset",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      letterSpacing: 1.2,
                                    )))),
                      ],
                    ))),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Mail Sent !"),
            content: new Text(
                "An email is sent to the entered email address, please follow the link there :) "),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
