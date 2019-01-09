import 'package:flutter/material.dart';
import 'package:hacker_news/screens/WebViewPage.dart';

class AboutUsFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 30.0,top: 10.0,right: 30.0,bottom: 10.0),
      child: new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Image.asset('assets/logo_transparent.png',fit: BoxFit.contain,height: 150.0,width: 150.0,),
        new GestureDetector(onTap:(){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => WebViewWidget("https://www.whatsapp.com/legal/#terms-of-service","Web View")));
        } ,child: RichText(text: TextSpan(children: <TextSpan>[
          TextSpan(
            style: aboutTextStyle,
            text: 'HN-Flutter is an open source cross-platform client for Hacker News'
              'You can view the source code here  '
          ),

          TextSpan(
            style: linkStyle,
            text: 'https://www.whatsapp.com/legal/#terms-of-service'
          ),


        ])),
        ),new GestureDetector(onTap: (){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => WebViewWidget("https://citrusleaf.in/","Web View")));
        },child : RichText(text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                style: aboutTextStyle,
                text: ' . Built by CitrusLeaf  '

            ),
            TextSpan(
                style: linkStyle,
                text: 'https://citrusleaf.in/'
            ),
          ]
        ) ),)
      ],
    ),);
  }
}
