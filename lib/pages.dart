import 'package:flutter/cupertino.dart';
import 'package:soundsaga/cover.dart';

class SingleRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return legacyStack();
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