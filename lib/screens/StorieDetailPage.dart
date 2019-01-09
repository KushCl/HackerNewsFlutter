import 'package:hacker_news/models/UserComments.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:html/parser.dart' show parse;

class StorieDetailPage extends StatelessWidget {
  List<UserComments> userCommentList = new List();
  String title;

  String url;

  StorieDetailPage(this.title ,this.url ,this.userCommentList);

  int postion = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: new DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: new AppBar(
            title: new Text(title),
          ),
          body: new ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    EntryItem(userCommentList[index]),
              itemCount: userCommentList.length,
            ),
          )),
    );
  }
}

class CommentSectionWidget extends StatelessWidget {
  int id;

  CommentSectionWidget(this.id);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CommentFabButton(),
    );
  }
}

/*class WebViewWidget extends StatelessWidget {
  String urls;
  String title ;

  WebViewWidget(this.urls,this.title);
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 100,

      child:  new WebviewScaffold(url: urls
        ,clearCache: true,),
      );

  }
}*/

class CommentsData extends StatefulWidget {
  int id;

  CommentsData(this.id);

  @override
  State<StatefulWidget> createState() => _CommentsDataState(id);
}

class _CommentsDataState extends State<CommentsData> {
  int id;

  List commentDataList = List();

  _CommentsDataState(this.id);

  @override
  void intiState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}

class CommentFabButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  CommentFabButton({this.onPressed, this.tooltip, this.icon});

  @override
  _CommentFabButtonState createState() => _CommentFabButtonState();
}

class _CommentFabButtonState extends State<CommentFabButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.amber,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget share() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btnShare",
        onPressed: _onShareClicked,
        tooltip: 'Share',
        child: Icon(Icons.share),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btnToogleAnimate",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: share(),
        ),
        toggle(),
      ],
    );
  }

  void _onShareClicked() {
    Share.share("https://github.com/HackerNews/API",
        sharePositionOrigin: Rect.fromCircle());
  }

  void _onLikeClicked() {}

  void _onBookMarkedClicked() {}
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final UserComments entry;

  String _parseHtmlString(String htmlString){
    var documents = parse(htmlString);
    String parsedString = parse(documents.body.text).documentElement.text;
    return parsedString;
  }

  Widget _buildTile(UserComments root) {
    if (root.comments.isEmpty) return _buildListItem(root);
    return ExpansionTile(
        key: PageStorageKey<UserComments>(root),
        title: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(root?.user ?? "" ,style: TextStyle(fontSize: 12.0),),
                new Text(" . " + root?.timeAgo ?? "",style: TextStyle(fontSize: 12.0),)
              ],
            ),ListTile(title: new Text(_parseHtmlString(root?.content ?? ""),style: TextStyle(fontSize: 14)),),
            Divider(color: Colors.grey,)

          ],
        )
     ,children: root.comments.map(_buildTile).toList());
  }
  Widget _buildListItem(UserComments root) {
    return Container(
      margin: EdgeInsets.only(left: 30.0,top: 8.0,right: 30.0,bottom: 8.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(root?.user ?? "",style: TextStyle(fontSize: 12.0),),
            new Text(" . " + root?.timeAgo ?? "",style: TextStyle(fontSize: 12.0),),
          ],
        ),
        ListTile(contentPadding: EdgeInsets.only(left: ((root.level-1)*10).toDouble()),subtitle: new Text(_parseHtmlString(root?.content ?? ""),style: TextStyle(fontSize: 14),),),
          Divider(color: Colors.grey,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        children: <Widget>[
          _buildTile(entry),
        ],
      ),
    );
  }
}
//home/dell/Documents/android3.2/android-studio/jre/bin/ keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key