import 'package:firebase_flutter_app/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String carModel;
  String carColor;
  QuerySnapshot cars;

  crudMethod crudObj = new crudMethod();

  Future<bool> addDialog(BuildContext context) async{
    return showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Data", style: TextStyle(fontSize: 15)),
            content: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter car Name",
                  ),
                  onChanged: (value){
                    this.carModel=value;
                  },
                ),
                SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter car Color",
                  ),
                  onChanged: (value){
                    this.carColor=value;
                  },
                ),
              ],
            ),
            actions: [
              FlatButton(
                child: Text("Add"),
                textColor: Colors.greenAccent,
                onPressed: (){
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColor,
                  }).then((result){
                    dialogTrigger(context);
                  }).catchError((e){
                    print(e);
                  });
                },
              ),
            ],
          );
        }
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async{
   return showDialog(
     context: context,
     barrierDismissible: false,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("Job Done", style: TextStyle(fontSize: 15),),
         content: Text("Added"),
         actions: [
           FlatButton(
               onPressed: (){
                 Navigator.of(context).pop();
               },
             child: Text("Alright"),
             color: Colors.greenAccent,

           ),
         ],
       );
     }
   );
  }

  @override
  void initState() {
    crudObj.getData().then((result){
     setState(() {
       cars=result;
     });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon:Icon(Icons.add, color: Colors.white),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
            crudObj.getData().then((result){
              setState(() {
                cars=result;
              });
            });
              }
          ),

        ],
      ),

      body: _carsList(),
    );
  }

  Widget _carsList(){
    if(cars != null){
      return ListView.builder(
        // ignore: deprecated_member_use
        itemCount: cars.documents.length,
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context, index){
          return ListTile(
            // ignore: deprecated_member_use
            title: Text(cars.documents[index].data()['carName']),
            // ignore: deprecated_member_use
            subtitle: Text(cars.documents[index].data()['color']),
          );
          },
      );
    }
    else{
      return Text('Loading, Please wait...');
    }
  }

}


