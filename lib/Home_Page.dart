import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You are logged in"),
              SizedBox(height: 15.0),

              OutlineButton(
                  borderSide: BorderSide(
                    color: Colors.green[600],
                    style: BorderStyle.solid, width: 3.0,
                  ),
                  child: Text("LogOut"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value){
                      Navigator.of(context).pushReplacementNamed('/landingpage');
                    }).catchError((e){
                      print(e);
                    });

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
