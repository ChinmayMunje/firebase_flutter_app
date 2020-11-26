import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  storeUser(user, context) {
    // ignore: deprecated_member_use
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed("/homePage");
    }).catchError((e){
      print(e);
    });
  }
}