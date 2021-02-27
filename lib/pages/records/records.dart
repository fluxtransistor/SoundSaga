import 'package:flutter/cupertino.dart';
import 'package:soundsaga/pages/records/stacks.dart';
import 'package:soundsaga/track.dart';


class SingleRecordPage extends StatefulWidget {
  @override
  _SingleRecordPageState createState() => _SingleRecordPageState();
}

class _SingleRecordPageState extends State<SingleRecordPage> {
  var _trackStack = [];
  var _incomingTrack;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget> [
          legacyStack(),
          CupertinoButton.filled(
              child: Text('Swipe!',style: CupertinoTheme.of(context).textTheme.textStyle),
              onPressed: () {},
          )
        ]
    );
  }
}

