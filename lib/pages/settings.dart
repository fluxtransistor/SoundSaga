import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings',
          style: CupertinoTheme.of(context).textTheme.textStyle),
    );
  }
}
