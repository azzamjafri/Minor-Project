import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minor_project/Authentication/sign_in.dart';
import 'package:minor_project/Auxiliary/custom_class.dart';
import 'package:minor_project/Home/home.dart';
import 'package:minor_project/Services/authentication.dart';

class SignupDetails extends StatefulWidget {
  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails> {
  String currentText;

  final formKey = GlobalKey<FormState>();
  final key = GlobalKey<ScaffoldState>();

  TextEditingController courseController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController passingYearController = TextEditingController();
  String departmentValue;
  List<String> department = [
    "FET",
    "Physiotherapy",
    "Law",
    "Other",
  ];
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
              key: formKey,
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
                        Padding(padding: EdgeInsets.all(15.0)),

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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Icon(
                                      Icons.book,
                                      size: 35,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                  hintText: "Enter Course"),
                              validator: (value) =>
                                  value.isEmpty ? 'Can\'t be empty' : null,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Icon(
                                      Icons.access_time,
                                      size: 35,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                  hintText: "Enter Passing Year"),
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value.isEmpty ? 'Can\'t be empty' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: Container(
                      height: 50,
                      width: 80.0,
                      child: DropdownButton(
                        elevation: 5,
                        hint: Text("Select Department"),
                        value: departmentValue,
                        onChanged: (val) {
                          setState(() {
                            departmentValue = val;
                          });
                        },
                        items: department.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
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
                                onPressed: () {
                                  verify();
                                },
                                child: Text("Continue",
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

  verify() {
    print(user.uid + "&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    Firestore.instance.collection('users').document(user.uid).updateData({
      "department": departmentValue,
      "course": courseController.text,
      "batch": passingYearController.text,
    }).whenComplete(() {
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()),(route) => false);
    });
  }
}
