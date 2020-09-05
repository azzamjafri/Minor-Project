
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor_project/Auxiliary/custom_class.dart';
import 'package:minor_project/Services/authentication.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


FirebaseUser user;


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String currentText;

  // Registration variables
  String smsCode, verificationId;
  bool codeSent = false;
  bool verified = false;
  bool registered = false;
  bool canRegister = false;
  AuthCredential loginKey;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double hit = displayHeight(context);
    double wid = displayWidth(context);
    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  height: 220,
                  child: Image.asset(
                    "assets/dellologo.png",
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
                      controller: phoneController,
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
                          
                          hintText: "Enter Phone Number"),
                          keyboardType: TextInputType.number,
                      validator: (value) {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment(.1, -1),
                    child: Container(
                      width: wid * .8,
                      // color: Color.fromRGBO(241,243,241, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text("OTP Recievied", style: TextStyle(fontSize: 12.0)),
                          ),
                          Container(
                            //color: Color.fromRGBO(241,243,241, 1),
                            width: 200,
                            //height: 200,
                            child: new PinCodeTextField(
                              appContext: context,
                              length: 6,
                              obsecureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                selectedColor: Colors.grey,
                                inactiveColor: Colors.grey,
                                selectedFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                shape: PinCodeFieldShape.circle,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 42,
                                fieldWidth: 30,
                                activeFillColor: Colors.white,
                              ),
                              //animationDuration: Duration(milliseconds: 300),
                              //backgroundColor: Colors.blue.shade50,
                              enableActiveFill: true,
                              //errorAnimationController: errorController,
                              controller: otpController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  phoneController.text = phoneController.text.trim();
                  codeSent
                      ? AuthService().signWithOTP(smsCode, verificationId)
                      : verifyPhone("+91" + phoneController.text);

                  if (verified) {
                    setState(() {
                      key.currentState.showSnackBar(SnackBar(content: Text('Phone Number Verified !'),));
                    });
                  }
                },
                child: Align(
                  alignment: Alignment(.6, -1),
                  child: codeSent
                      ? Text("Submit the OTP Code",
                          style: TextStyle(color: Colors.green))
                      : Text("Get OTP", style: TextStyle(color: Colors.green)),
                  // child: Text("Get OTP",style: TextStyle(color: Colors.green),),
                ),
              ),
              FlatButton(
                  onPressed: () {},
                  child: Align(
                    alignment: Alignment(0, -1),
                    child: Text("Or Login By Email"),
                  )),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 150,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/j.png'),
                            fit: BoxFit.fitHeight),
                      ),
                      child: Align(
                          alignment: Alignment(0.3, -.15),
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                    ),
                    Container(
                      width: 150,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/p.png'),
                            fit: BoxFit.fitHeight),
                      ),
                      child: Align(
                          alignment: Alignment(0.3, -.15),
                          child: Text(
                            "Signin",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  height: 40,
                  width: wid * .5,
                  child: FlatButton(
                      onPressed: () {
                        if(verified){
                          Navigator.pushNamedAndRemoveUntil(context, '/homescreen', (route) => false);
                        }
                        else{
                          key.currentState.showSnackBar(SnackBar(content: Text('Please Verify Phone !! '), duration: Duration(seconds: 3)));
                        }
                      },
                      child: Text("Sign in"))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                child: Container(
                    height: 27,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                                children: [
                              TextSpan(text: "Don\'t have an Account? "),
                              TextSpan(
                                  text: "Register",
                                  style: TextStyle(color: Colors.green))
                            ])))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      // AuthService().signIn(authResult);
      FirebaseAuth.instance
          .signInWithCredential(authResult)
          .then((usser) async {
        canRegister = true;
        user = await FirebaseAuth.instance.currentUser();
      });
      setState(() async {
        this.verified = true;
        this.loginKey = authResult;
        otpController.text = smsCode;
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}' + '***************************************');

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