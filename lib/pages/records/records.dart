import 'package:flutter/cupertino.dart';
import 'package:soundsaga/pages/records/stacks.dart';
import 'package:soundsaga/track.dart';

class SingleRecordPage extends StatefulWidget {
  @override
  SingleRecordPageState createState() => SingleRecordPageState();
}

class SingleRecordPageState extends State<SingleRecordPage> {
  var tracks = [
    DemoTrack1(),
    DemoTrack2(),
    DemoTrack1(),
    DemoTrack2(),
  ];
  var current = 0;
  final CoverStackController stackController = CoverStackController();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CoverStack(
            tracks: tracks,
            controller: stackController,
          ),
          Text(
            "Track Name",
            style: CupertinoTheme.of(context).textTheme.textStyle
          ),
          Row(children: [
            CupertinoButton.filled(
              child: Text('Prev',
                  style: CupertinoTheme.of(context).textTheme.textStyle),
              onPressed: () {
                if (current > 0) {
                  current -= 1;
                  stackController.goto(current);
                }
              },
            ),
            CupertinoButton.filled(
              child: Text('Next',
                  style: CupertinoTheme.of(context).textTheme.textStyle),
              onPressed: () {
                if (current < tracks.length - 1) {
                  current += 1;
                  stackController.goto(current);
                }
              },
            ),]
          )
        ]);
  }
}
