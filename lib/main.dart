import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soundsaga/track.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() async {

  try {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
  }  catch (e) {
    print(e);
  }

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound Saga',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _pages = [
    SingleRecordPage(),
    ListPage(),
    SettingsPage() //
  ];


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Sound Saga'),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.music_albums)),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_dash)),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings))
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _pages[index];
          }),
    );
  }
}

class SingleRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        Transform.rotate(angle: 0.04,
        child:
          SizedBox(
          width: 280.00,
          height: 280.00,
          child: const DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0,0,0, 0.5),
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(3, 3), // changes position of shadow
                ),
              ],
            ),
            // Put Your Child widget here.
          ),
          ),
        ),
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('List',style: CupertinoTheme.of(context).textTheme.textStyle),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings',style: CupertinoTheme.of(context).textTheme.textStyle),
    );
  }
}