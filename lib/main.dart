import 'package:flutter/cupertino.dart';
import 'package:soundsaga/pages.dart';

void main() async {
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