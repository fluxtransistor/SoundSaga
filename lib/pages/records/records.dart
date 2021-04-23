import 'package:flutter/cupertino.dart';
import 'package:soundsaga/pages/records/stacks.dart';
import 'package:soundsaga/track.dart';

class SingleRecordPage extends StatefulWidget {
  @override
  SingleRecordPageState createState() => SingleRecordPageState();
}

class SingleRecordPageState extends State<SingleRecordPage> {
  var tracks = <Track>[];
  var current = 0;
  final CoverStackController stackController = CoverStackController();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CoverStack(
            tracks: [
              DemoTrack1(),
              DemoTrack2(),
              DemoTrack1(),
              DemoTrack2(),
            ],
            controller: stackController,
          ),
          CupertinoButton.filled(
            child: Text('Swipe!',
                style: CupertinoTheme.of(context).textTheme.textStyle),
            onPressed: () {
              current += 1;
              stackController.goto(current);
            },
          )
        ]);
  }
}
