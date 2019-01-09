import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainFetchData2 extends StatefulWidget{
  @override
  DataFetchState createState() => DataFetchState();

}

class DataFetchState extends State<MainFetchData2>{
  List list = List();
  var isLoading = true ;

  @override
  void initState(){
      _fetchDataSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("Data fetching "),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(8.0),
      child: RaisedButton(child: new Text("Fetch Data"),onPressed: _fetchDataSync),),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(""),
              );
            }));

  }

  _fetchDataSync() async{
    setState(() {
    });
    final response = await http.get("https://api.hnpwa.com/v0/item/13831370.json");
    if(response.statusCode == 200 ){



    }else{
      throw Exception("Failed to load data");
    }
  }

}

