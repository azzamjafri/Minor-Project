import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:minor_project/Auxiliary/custom_class.dart';
import 'package:minor_project/Services/authentication.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

bool phoneVerified = false;
bool emailVerified = false;
bool gstVerified = false;
bool signatureVerified = false;
bool bankAccountVerified = false;
bool cancelChequeVerified = false;
String email;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String currentText;
  final key = GlobalKey<ScaffoldState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController passingYearController = TextEditingController();

  

  // Registration variables
  String smsCode, verificationId;
  bool codeSent = false;
  bool verified = false;
  bool registered = false;
  bool canRegister = false;
  AuthCredential loginKey;

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
            /*decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/back.png'),fit: BoxFit.fitWidth)
            ),*/
            child: Form(
              child: ListView(
                /*    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,*/
                children: [
                  Container(
                      height: 180.0,
                      child: Image.asset(
                        "assets/logo.png",
                      )),
                  Container(
                    height: 240,
                    child: Align(
                      alignment: Alignment(0, -1),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            //color: Colors.,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Icon(
                                        Icons.person,
                                        size: 35,
                                        color: Colors.black.withOpacity(.75),
                                      ),
                                    ),
                                    hintText: "Enter Username"),
                                validator: (value) {},
                              ),
                            ),
                          ),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Icon(
                                        Icons.email,
                                        size: 35,
                                        color: Colors.black.withOpacity(.75),
                                      ),
                                    ),
                                    hintText: "Enter Email"),
                                validator: (value) {},
                              ),
                            ),
                          ),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Icon(
                                        Icons.phone,
                                        size: 35,
                                        color: Colors.black.withOpacity(.75),
                                      ),
                                    ),
                                    hintText: "Enter Phone Number"),
                                keyboardType: TextInputType.number,
                                validator: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment(.1, -1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text("OTP Recievied",
                                style: TextStyle(fontSize: 15.0)),
                          ),
                          Container(
                            color: Color.fromRGBO(241, 243, 241, 1),

                            width: 220,
                            // height: 200,
                            child: PinCodeTextField(
                              appContext: context,
                              length: 6,
                              obsecureText: false,
                              animationType: AnimationType.fade,
                              autoDisposeControllers: false,
                              pinTheme: PinTheme(
                                selectedColor: Colors.grey,
                                inactiveColor: Colors.grey,
                                selectedFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                shape: PinCodeFieldShape.circle,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 34,
                                activeFillColor: Colors.grey,
                              ),

                              //animationDuration: Duration(milliseconds: 300),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              //errorAnimationController: errorController,
                              controller: otpController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                // setState(() {
                                currentText = value;
                                // });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(.6, -1),
                    child: GestureDetector(
                        onTap: () {
                          phoneController.text = phoneController.text.trim();
                          codeSent
                              ? AuthService()
                                  .signWithOTP(smsCode, verificationId)
                              : verifyPhone("+91" + phoneController.text);

                          if (verified) {
                            setState(() {
                              key.currentState.showSnackBar(SnackBar(
                                content: Text('Phone Number Verified !'),
                              ));
                            });
                          }
                        },
                        child: codeSent
                            ? Text("Submit the OTP Code",
                                style: TextStyle(color: Colors.blue))
                            : Text("Get OTP",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15.0,
                                ))),
                  ),
                  Container(
                    height: 240.0,
                    child: Align(
                      alignment: Alignment(0, -1),
                                        child: Column(

                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: wid * .8,
                            height: 52.0,
                            child: Material(
                              elevation: 5,
                              shape: StadiumBorder(),
                              child: TextFormField(
                                controller: courseController,
                                enableInteractiveSelection: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 4),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(30))),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Icon(
                                        Icons.book,
                                        size: 35,
                                        color: Colors.black.withOpacity(.75),
                                      ),
                                    ),
                                    hintText: "Enter Course"),
                                validator: (value) {},
                              ),
                            ),
                          ),

                          Container(
                            width: wid * .8,
                            height: 52.0,
                            child: Material(
                              elevation: 5,
                              shape: StadiumBorder(),
                              child: TextFormField(
                                controller: deptController,
                                enableInteractiveSelection: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 4),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(30))),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Icon(
                                        Icons.school,
                                        size: 35,
                                        color: Colors.black.withOpacity(.75),
                                      ),
                                    ),
                                    hintText: "Enter Department"),
                                validator: (value) {},
                              ),
                            ),
                          ),

                          Container(
                            width: wid * .8,
                            height: 52.0,
                            child: Material(
                              elevation: 5,
                              shape: StadiumBorder(),
                              child: TextFormField(
                                controller: passingYearController,
                                enableInteractiveSelection: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 4),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(30))),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Icon(
                                        Icons.access_time,
                                        size: 35,
                                        color: Colors.black.withOpacity(.75),
                                      ),
                                    ),
                                    hintText: "Enter Passing Year"),
                                    keyboardType: TextInputType.number,
                                validator: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            height: 50,
                            width: wid * .7,
                            child: FlatButton(
                                onPressed: () async {
                                  
                                  if (canRegister) {
                                    email = emailController.text;
                                    await Firestore.instance
                                        .collection('sellers')
                                        .document(user.uid)
                                        .setData({
                                      'name': userNameController.text,
                                      'email': emailController.text,
                                      'phone': phoneController.text,
                                      
                                      
                                      'password': 'test1234',
                                    });
                                    AuthService().signUpWithEmail(
                                        emailController.text.trim(),
                                        'test1234');
                                    AuthService().sendEmailVerification();
                                    Navigator.pushNamed(
                                        context, '/getbusinessdetails');
                                  } else {
                                    key.currentState.showSnackBar(SnackBar(
                                      content: Text('Something Went Wrong !!'),
                                    ));
                                  }
                                },
                                child: Text(
                                    
                                        
                                         "Continue",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22.0)))),
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

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      FirebaseAuth.instance
          .signInWithCredential(authResult)
          .then((usser) async {
        if (emailController != null &&
            phoneController != null &&
            userNameController != null) {
          canRegister = true;
          phoneVerified = true;
        }
        await FirebaseAuth.instance.currentUser().then((value) {
          user = value;
        });
      });
      setState(() async {
        this.verified = true;
        this.loginKey = authResult;
        otpController.text = smsCode;
        AuthService().signUpWithEmail(emailController.text.trim(), 'test1234');
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}' +
          '***************************************');

      if (registered)
        key.currentState.showSnackBar(SnackBar(
          content: new Text('Already Registered please try Login'),
        ));

      registered = false;
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
