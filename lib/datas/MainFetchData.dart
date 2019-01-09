import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  List list = List();
  Map cardList = {};
  int index = 0 ;
  var isLoading = false;
  List<Model> modelList;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: new Text("FetchData JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text('Fetch Data'),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(modelList[index].title),
                  );
                }));
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("https://api.hnpwa.com/v0/news/1.json");
    if (response.statusCode == 200) {
      //debugPrint(response.body);
      list = jsonDecode(response.body) as List;

      modelList = list.map((data) => Model.fromJson(data)).toList();
      /*modelList.map((model) => print(model.title));
      modelList.map((model) => print(model.id));*/
      setState(() {
        isLoading = false ;
        this.modelList = list[index];
        this.index++ ;
      });
      for (Model item in modelList) {
        String title = item.title;
        print(title);
      }

      /*list = json.decode(response.body) as List;
     setState(() {
       isLoading = false;
     });*/

    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Model {
  String title, user, timeAgo, type, urls, domain;
  int id, points, time, commentsCount;

  Model(
      {this.id,
      this.title,
      this.points,
      this.user,
      this.time,
      this.timeAgo,
      this.commentsCount,
      this.type,
      this.urls,
      this.domain});

  factory Model.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['title']);
    return Model(
        title: parsedJson['title'],
        id: parsedJson['id'],
        points: parsedJson['points'],
        user: parsedJson['user'],
        time: parsedJson['time'],
        timeAgo: parsedJson['time_ago'],
        commentsCount: parsedJson['comments_count'],
        type: parsedJson['type'],
        urls: parsedJson['url'],
        domain: parsedJson['domain']);
  }
}
