import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minor_project/Services/authentication.dart';
import 'package:minor_project/colors.dart';



class MyDrawer extends StatefulWidget {

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String name;
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('users').document(user.uid).get().then((value) {
      print(value.data);
      print("************************************");
      setState(() => name = value.data['name']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: blueColor,
            child: DrawerHeader(
              child: Center(
              child: Container(
                color: blueColor,
                child: Column(
                  children: [
                    Align(alignment: Alignment(-1,-1),child: Icon(Icons.close, color: Colors.white,)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35,0,0,0),
                      child: Center(
                        //alignment: Alignment(1,1),
                        child: Row(
                          children: [
                            // Icon(Icons.person_pin,size: 70,),
                            Container(
                              height: 75.0,
                              width: 75.0,
                              // child: Image.asset('', color: Colors.black,)
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${user.email}", style: TextStyle(color: Colors.white),),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,15,0,0),
                                  child: Text("Jamia Millia Islamia", style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/rateus');
                      },
                                          child: Padding(
                        padding: const EdgeInsets.only(top:18.0),
                        child: Align(alignment: Alignment(1,1),child: Text("Rate Us", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline, decorationThickness: 1.5),)),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/');
              },
            child: ListTile(
              onLongPress: null,
              title: Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 35.0),
                      // child: Image.asset('assets/Icon awesome-mobile-alt.png'),
                    ),
                    
                    Text(
                      "Something here",
                      style: TextStyle(
                        //fontSize: 15,
                          color: blueColor),
                    ),
                    Spacer(),Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Icon(Icons.arrow_forward_ios,color: blueColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          





        ],
      ),
    );
  }
}