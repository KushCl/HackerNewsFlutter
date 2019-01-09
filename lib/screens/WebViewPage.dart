import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:hacker_news/screens/StorieDetailPage.dart';


class WebViewWidget extends StatelessWidget {
  String urls;
  String title ;
  var isLoading = false ;

  WebViewWidget(this.urls,this.title);
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading ? Center(child: CircularProgressIndicator())  : Scaffold(
      body: new WebviewScaffold(url: urls,appBar: new AppBar(title: new Text(title),),clearCache: true,),
    );

  }
}

/*
class WebView extends StatefulWidget{
  String url , title ;
  WebView(this.url,this.title);
  @override
  _WebViewState createState() => new _WebViewState(url,title);
}

class _WebViewState extends State<WebView>{
  String url , title ;
  _WebViewState(this.url,this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text(title),),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new WebviewScaffold(url: url,clearCache: true,),
          ],
        ),
      ),floatingActionButton: FloatingActionButton(
      onPressed: (){

      },
      tooltip: 'Comments',
      child: Icon(Icons.comment),
    ),
    );
  }
}*/
