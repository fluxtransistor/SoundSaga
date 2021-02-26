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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Text(_track.trackName),
          _track.img,
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonPress,
        tooltip: 'Fetch',
        child: Icon(Icons.cloud_download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
