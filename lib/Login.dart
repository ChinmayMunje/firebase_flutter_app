import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
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

  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: _email);

    } catch(e){
      print(e.toString());
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
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
                SizedBox(height: 8.0),

                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text("Forgot Password ?"),
                  ),
                ),
                SizedBox(height: 16.0),

                GestureDetector(
                  onTap: (){
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((user){
                      Navigator.of(context).pushReplacementNamed('/dashboard');
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
                    child: Text("Login",style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 16.0),

                GestureDetector(
                  onTap: (){
                    signInWithGoogle().then((result) {
                      if(result != null){
                        Navigator.of(context).pushReplacementNamed('/dashboard');
                      }
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.google, color: Colors.orange),
                          SizedBox(width: 5),
                          Text("Sign in with Google",style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: 7.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account ? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/signup');
                      },
                        child: Text("Register now", style: TextStyle(color: Colors.white,fontSize: 17, decoration: TextDecoration.underline))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
