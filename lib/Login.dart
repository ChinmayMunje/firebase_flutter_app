import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Google SignIn Authentication
import 'package:google_sign_in/google_sign_in.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }
  

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
              SizedBox(height: 16.0),

              RaisedButton(
                  child: Text("LOGIN"),
                  color: Colors.green[600],
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: (){
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((user) {
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    }).catchError((e) {
                      print(e);
                    });
                  }
              ),
              SizedBox(height: 7.0),

              Text("Don't have an Account ?"),
              SizedBox(height: 10.0),

              RaisedButton(
                  child: Text("SIGN UP"),
                  color: Colors.green[600],
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  }
              ),

              SizedBox(height: 16.0),

              RaisedButton(
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.deepOrange),
                      SizedBox(width: 4.0),
                      Text('SignIn with Google'),
                    ],
                  ),
                  color: Colors.green[600],
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: (){
                    // _signIn().whenComplete(() async {
                    //   FirebaseUser user = await FirebaseAuth.instance.currentUser;
                    //   Navigator.of(context).pushReplacementNamed('/homepage');
                    // });

                    signInWithGoogle().then((result){
                      if(result != null){
                          Navigator.of(context).pushReplacementNamed('/homepage');
                      }
                    });
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
