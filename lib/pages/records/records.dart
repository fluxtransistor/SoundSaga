import 'package:flutter/cupertino.dart';
import 'package:soundsaga/pages/records/stacks.dart';
import 'package:soundsaga/track.dart';


class SingleRecordPage extends StatefulWidget {
  @override
  _SingleRecordPageState createState() => _SingleRecordPageState();
}

class _SingleRecordPageState extends State<SingleRecordPage> {
  var _tracks = [];
  var _incomingTrack;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          CoverStack(tracks: [NullTrack()],),
          CupertinoButton.filled(
              child: Text('Swipe!',style: CupertinoTheme.of(context).textTheme.textStyle),
              onPressed: () {},
          )
        ]
    );
  }
}

