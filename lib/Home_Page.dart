import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_app/SearchScreen.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut().then((value){
                Navigator.of(context).pushReplacementNamed('/landingpage');
              }).catchError((e){
                print(e);
              });
            },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.exit_to_app, color: Colors.white)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.search,color: Colors.white),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Screen()));
        },
      ),

    );
  }
}
