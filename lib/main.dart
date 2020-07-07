import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{

  final String url = "http://www.eatfresh.cc/arch_daily/api/listOfEvent";
  List data;
  var  newdata;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
   var response = await http.get(
     // Encode the url
     Uri.encodeFull(url),
     //only accept json response
     //headers: {"Accept": "application/json"}
   );

   print(response.body);
   setState(() {
     var convertDataToJson = json.decode(response.body);
//     data = convertDataToJson['res_data'];

     data = convertDataToJson["res_data"]["list_event"];

   });

   return "Success";
  }

  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Retrive Json via HTTP Get"),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                      child: new Container(
                        child: new Text(data[index]['event_name']),
                        padding: const EdgeInsets.all(20.0),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}