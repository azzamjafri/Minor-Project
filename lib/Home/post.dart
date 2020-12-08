import 'package:flutter/material.dart';
import 'package:minor_project/Services/authentication.dart';
import 'package:minor_project/Services/drawer.dart';
import 'package:minor_project/colors.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Post'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(8.0)),
            heading(),
            Padding(padding: EdgeInsets.all(8.0)),
            post(),
            Padding(padding: EdgeInsets.all(20.0)),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Comments...",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.4,
                        
                      ))),
            ),
            // Padding(padding: EdgeInsets.all(8.0)),
            comments(),
            Padding(padding: EdgeInsets.all(8.0)),
          ],
        ),
      ),
    );
  }

  heading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("POST HEADING",
            style: TextStyle(
                fontSize: 24.0,
                // fontStyle: FontStyle.italic,
                letterSpacing: 1.4,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  post() {
    return new Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width - 80.0,
      child: Center(
        child: Text(
          "Post Text",
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.blueGrey, spreadRadius: 8.0),
        ],
      ),
    );
  }

  comments() {
    return new ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(5.0),
      itemBuilder: (BuildContext context, int position) {
        return Column(
          children: [
            Divider(thickness: 1.2,),

            new ListTile(
              title: new Text(
                "Name of the person",
                style: new TextStyle(fontSize: 14.9),
              ),
              subtitle: new Text(
                "Some more random text from a really long comment. Checking whether it will fit in this area or not",
                style: new TextStyle(
                    fontSize: 13.4, color: brownColor, fontStyle: FontStyle.italic),
              ),
              leading: new CircleAvatar(
                radius: 22.0,
                backgroundColor: blueColor,
                child: new Text(
                  "${user.email.substring(0, 3).toUpperCase()}",
                  style:
                      new TextStyle(fontSize: 19.2, color: Colors.deepOrangeAccent),
                ),
              ),
              onTap: () {
                // _showOnTapMessage(context, "Text hi text");
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Post()));
              },
            ),

            Divider(thickness: 1.2,),

          ],
        );
      },
    );
  }
}
