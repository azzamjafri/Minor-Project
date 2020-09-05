import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:minor_project/Home/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

  String email = "";
  String phone = "";

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formkey = GlobalKey<FormState>();
  bool valid;

  String password = "";
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
        'email': email,
        'phone': phone,
        
      });
      setState(() {
        loading=false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
      submit(email.trim(), password.trim(), phone.trim(), cont);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            color: Colors.green,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Register Now",
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.normal)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Stack(children: [
            Container(
              height: 750,
            ),
            Positioned(
                left: 140,
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset('images/logo.jpg'),
                )),
            Positioned(
              top: 120,
              left: 106,
              child: Text(
                'Jhatpat shadi kro',
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 200,
              child: Text(
                'My Email Address is',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 230,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ' Enter A Vaid Email';
                      } else
                        return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                    cursorColor: Colors.green,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Email Address',
                        hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 290,
              child: Text(
                'My phone number is',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 320,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: 50,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new TextFormField(
                      key: ValueKey('phone'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return ' Enter A Vaid Number';
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        phone = value;
                      },
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                      cursorColor: Colors.green,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Phone Number',
                          hintStyle: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 20,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 380,
              child: Text(
                'Set My Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 410,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: 50,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new TextFormField(
                      obscureText: true,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.length < 8) {
                          return ' Minimum 8 Characters Must Be Present';
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                      cursorColor: Colors.green,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Set Your Password',
                          hintStyle: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 20,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: RaisedButton(
                  onPressed: () {
                    trysubmit(context);
                  },
                  child: Container(
                    height: 60,
                    width: 400,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 13,
                        ),
                        if (!loading)
                          Text("Continue",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white))
                        else
                          CircularProgressIndicator(backgroundColor: Colors.white,),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.green,
                      )),
                  color: Colors.green),
            ),
          ]),
        ),
      ),
    );
  }
}