import 'package:flutter/material.dart';
import 'package:hacker_news/fragments/AboutUsFragment.dart';
import 'package:hacker_news/fragments/CatchUpFragment.dart';
import 'package:hacker_news/fragments/NewStoriesFragment.dart';
import 'package:hacker_news/fragments/TopStoriesFragment.dart';


class DrawerItem{

  String title ;
  IconData icon ;

  DrawerItem(this.title , this.icon);
}


class HomePage extends StatefulWidget{
  final drawerItem = [
    new DrawerItem("Top Stories", Icons.rss_feed),
    new DrawerItem("Catch Up",Icons.important_devices),
    new DrawerItem("New Stories", Icons.flash_on),
    new DrawerItem("About Us", Icons.supervisor_account)
  ];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  int _selectDrawerIndex = 0;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0:
        return new TopStoriesFragment();
      case 1:
        return new CatchUpFragment();
      case 2:
        return new NewStoriesFragment();
      case 3 :
        return new AboutUsFragment();
      default :
        new Text("error");
    }
  }

  _onSelectedItem(int index){

    setState(() => _selectDrawerIndex = index);
    Navigator.of(context).pop();//close drawer

  }
  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItem.length; i++) {
      var d = widget.drawerItem[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectDrawerIndex,
            onTap: () => _onSelectedItem(i),
          )
      );
    }

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItem[_selectDrawerIndex].title),

      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text(""), accountEmail: new Text(""),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage('assets/logo_transparent.png',),
                  fit: BoxFit.contain,
                ),
              ),

            ),new Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body:_getDrawerItemWidget(_selectDrawerIndex),
    );
  }
}
