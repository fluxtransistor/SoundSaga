import 'package:flutter/cupertino.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('List',style: CupertinoTheme.of(context).textTheme.textStyle),
    );
  }
}
