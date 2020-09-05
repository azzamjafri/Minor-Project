import 'package:flutter/material.dart';
import 'package:minor_project/Authentication/sign_in.dart';
import 'package:minor_project/colors.dart';

void main() {
  runApp(MinorProject());
}

class MinorProject extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minor Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: blueColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn(),
    );
  }
}
