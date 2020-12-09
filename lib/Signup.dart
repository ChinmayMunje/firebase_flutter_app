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

              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((signedInUser){
                    UserManagement().storeUser(signedInUser, context);
                  }).catchError((e){
                    print(e);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        colors: [Colors.lightGreenAccent,Colors.green[700]]
                    ),
                  ),
                  child: Text("Sign up",style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
