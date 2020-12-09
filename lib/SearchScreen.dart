import 'package:firebase_flutter_app/services/UserManagement.dart';
import 'package:flutter/material.dart';

class Search_Screen extends StatefulWidget {
  @override
  _Search_ScreenState createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: (){
                          },
                          child: Icon(Icons.search,color: Colors.white)),
                      hintText:'Search Username....',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
