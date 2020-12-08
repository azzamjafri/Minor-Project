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
    

    return Scaffold(
      appBar: AppBar(
        title: new Text('Minor project'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(padding: const EdgeInsets.all(6.0)),

            addPost(),

            postButton(),

            Padding(padding: const EdgeInsets.all(8.0)),

            divider(Colors.indigoAccent[100], 40, 2.0),
            
            Padding(padding: const EdgeInsets.all(4.0)),

            listOfPosts(),
          ],
        ),
      ),
    );
  }


  divider(c, w, t) {

    return Container(
              width: MediaQuery.of(context).size.width - w,
              child: Divider(thickness: t, color: c,));

  }

  postButton() {

    return Padding(
      padding: EdgeInsets.only(right: 20.0),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RaisedButton(
            onPressed: (){},
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.black)
            ),
            textColor: Colors.white,
            color: Colors.blueGrey,
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.add),
                Padding(padding: EdgeInsets.all(3.5),),
                Text("POST", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, letterSpacing: 1.2, fontSize: 16.6),)
              ],
            ),
          ),
        ],
      ),
    );

  }

  addPost() {
    const _maxLines = 10;
    return Container(
      margin: EdgeInsets.all(12.0),
      height: _maxLines * 14.5,
      child: new TextField(
        controller: _queryController,
        maxLines: _maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: maroonRedColor, width: 2.0)),
          hintText:
              'Please describe your problem or suggestion in detail, we will follow up and solve it as soon as possible.',
        ),
      ),
    );
  }

  listOfPosts() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(5.0),
      itemBuilder: (BuildContext context, int position) {
        return Column(
          children: [


            new ListTile(
              title: new Text(
                "Heading for the thread",
                style: new TextStyle(fontSize: 14.9),
              ),
              subtitle: new Text(
                "Some more random text from the post",
                style: new TextStyle(
                    fontSize: 13.4, color: brownColor, fontStyle: FontStyle.italic),
              ),
              leading: new CircleAvatar(
                radius: 30.0,
                
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

            divider(Colors.blueGrey, 120.0, 0.85),
          ],
        );
      },
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
