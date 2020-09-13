import 'package:flutter/material.dart';
import 'package:minor_project/Services/authentication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Minor project'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome, ' + user.email + ' !'),
      ),
    );
  }
}
