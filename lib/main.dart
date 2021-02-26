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
    return new Stack(
      children: <Widget>[
      Center(
      child:
        Transform.rotate(angle: 0.08,
        child:
          SizedBox(
          width: 280.00,
          height: 280.00,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0,0,0, 0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
          ),
          ),
        ),
      ),
        Center(
          child:
          Transform.rotate(angle: 0.01,
            child:
            SizedBox(
              width: 280.00,
              height: 280.00,
              child: const DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0,0,0, 0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child:
          Transform.rotate(angle: -0.06,
            child:
            SizedBox(
              width: 280.00,
              height: 280.00,
              child: const DecoratedBox(
                child:
                    ClipRRect(child: Image(image: AssetImage('assets/dsotm.jpg')), borderRadius: BorderRadius.all(Radius.circular(5)),),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0,0,0, 0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]
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