import 'package:firebase_flutter_app/services/UserManagement.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 10.0),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 20.0),

              RaisedButton(
                  child: Text("SIGN UP"),
                  color: Colors.green[600],
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).then((signedInUser){
                      UserManagement().storeUser(signedInUser, context);
                    }).catchError((e) {
                      print(e);
                    });
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
