import 'package:flutter/material.dart';
import 'package:hacker_news/datas/MainFetchData.dart';
import 'package:hacker_news/models/UserComments.dart';
import 'package:hacker_news/screens/StorieDetailPage.dart';
import 'package:hacker_news/screens/WebViewPage.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';


class CatchUpFragment extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _CatchUpFragmentState();

}

class _CatchUpFragmentState extends State<CatchUpFragment>{

  var isLoading = false;
  ScrollController _scrollController;
  Map<String, dynamic> commentMap = new Map();
  Map contentMap = new Map();
  List<Model> modelList = new List();
  int page = 1;

  List<UserComments> userCommentList = new List();
  CircularProgressIndicator circularProgressIndicator = new CircularProgressIndicator();
  _scrollControllerListener() {
    if (_scrollController.position.extentAfter <= 0) {
      setState(() {
        _fetchNewestNews();
      });
    }
  }

  void initState(){
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollControllerListener);
    _fetchNewestNews();
    super.initState() ;
  }
  
  Future<void> _fetchNewestNews() async{
    setState(() {
      isLoading = true ;
    });
    final response = await http.get("https://api.hnpwa.com/v0/show/$page.json");
    if(response.statusCode == 200 ){
      List<Model>list = (jsonDecode(response.body) as List)
          .map((data) => Model.fromJson(data))
          .toList();
      setState(() {
        isLoading = false ;
        modelList.addAll(list);

      });
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      Exception("Failed to load data");
    }
  }

  Future<void> _fetchCommentData(String title,String url,int id) async {
    setState(() {
      isLoading = true ;
    });
    final response = await http.get("https://api.hnpwa.com/v0/item/$id.json");
    if (response.statusCode == 200) {
      contentMap = jsonDecode(response.body) as Map;
      setState(() {
        List<UserComments> list = (contentMap['comments'] as List)
            .map((data) => UserComments.fromJson(data))
            .toList();
        userCommentList.addAll(list);
        isLoading = false ;
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new StorieDetailPage(title, url, userCommentList)));
        return Center(
          child: CircularProgressIndicator(),
        );
      });
    } else {
      throw Exception("Failed to load data.. ");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:isLoading ? Center(child: CircularProgressIndicator()) : new RefreshIndicator(onRefresh: _fetchNewestNews,child: new ListView.builder(
          controller: _scrollController,
          itemCount: modelList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                    leading: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          '${modelList[index].points ?? "Empty"}',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        new Icon(
                          Icons.whatshot,
                          size: 20.0,
                          color: Colors.amber,
                        )

                      ],
                    ),
                    title: new Text(
                      modelList[index]?.title ?? "",
                      style: new TextStyle(fontSize: 15.0),
                    ),
                    subtitle: new Text(
                      modelList[index]?.domain ?? "" ,
                      style: TextStyle(fontSize: 10.0),
                    ),
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new WebViewWidget(modelList[index].urls, modelList[index].title)));
                    },
                  ),
                  new ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: new ButtonBar(
                      children: <Widget>[
                        new Text(
                          modelList[index]?.timeAgo ?? "",
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _fetchCommentData(modelList[index].title,modelList[index].urls,modelList[index].id);
                          },
                          child: new Icon(
                              Icons.message,
                              size: 25.0, color: Colors.redAccent
                          ),
                        ),new Text('${modelList[index].commentsCount ?? "Empty"}',
                            style: TextStyle(
                              fontSize: 8.0,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })
      ),
    );
  }

}