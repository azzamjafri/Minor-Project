import 'package:flutter/material.dart';
import 'package:minor_project/Home/post.dart';
import 'package:minor_project/Services/authentication.dart';
import 'package:minor_project/Services/drawer.dart';
import 'package:minor_project/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _queryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    const _maxLines = 10;

    return Scaffold(
      appBar: AppBar(
        title: new Text('Minor project'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      // body: Center(
      //   child: Text('Welcome, ' + user.email + ' !'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              height: _maxLines * 12.0,
              child: new TextField(
                controller: _queryController,
                maxLines: _maxLines,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: maroonRedColor, width: 2.0)),
                  hintText:
                      'Please describe your problem or suggestion in detail, we will follow up and solve it as soon as possible.',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
            ),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.vertical,
              
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (BuildContext context, int position) {
                return new ListTile(
                  title: new Text(
                    "RAndom Text",
                    style: new TextStyle(fontSize: 14.9),
                  ),
                  subtitle: new Text(
                    "Some more random text",
                    style: new TextStyle(
                        fontSize: 13.4,
                        color: brownColor,
                        fontStyle: FontStyle.italic),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: blueColor,
                    child: new Text(
                      "${user.email.substring(0, 3).toUpperCase()}",
                      style: new TextStyle(
                          fontSize: 19.2, color: Colors.deepOrangeAccent),
                    ),
                  ),
                  onTap: () {
                    // _showOnTapMessage(context, "Text hi text");
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new Post()));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showOnTapMessage(BuildContext context, String message) {
    var alert = new AlertDialog(
      title: new Text("App"),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text("OK"))
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
