import 'package:flutter/material.dart';
import 'package:hacker_news/pages/HomePage.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.network("https://is1-ssl.mzstatic.com/image/thumb/Purple128/v4/61/e7/6d/61e76d36-7b44-7173-2540-412605060935/AppIcon-1x_U007emarketing-85-220-0-6.png/246x0w.jpg"),

    ),
  );

  final email = TextFormField(
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    initialValue: 'kushal@gmail.com',
    decoration: InputDecoration(
      hintText: 'Email',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );

  final password = TextFormField(
    autofocus: false,
    initialValue: 'some password',
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );

  final loginButton = Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        // enter the route here ..
      },
      padding: EdgeInsets.all(12),
      color: Colors.amber,
      child: Text('Log In', style: TextStyle(color: Colors.white)),
    ),
  );

  final forgotLabel = FlatButton(
    child: Text(
      'Forgot password?',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );



    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.5,right: 24.5),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0,),
            email,
            SizedBox(height: 8.0,),
            password,
            SizedBox(height: 24.5,),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }



}