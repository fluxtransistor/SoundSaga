import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soundsaga/track.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() async {

  try {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.black);
  }  catch (e) {
    print(e);
  }

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Sound Saga'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Track _track = new Track("3766509");
  DateTime _chartDate = DateTime.utc(1979,06,03);

  void _buttonPress() {
    setState(() {
      _track.load();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
