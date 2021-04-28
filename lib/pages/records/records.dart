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
  int _currPos = 0;
  Track _currTrack;
  final CoverStackController stackController = CoverStackController();

  @override
  Widget build(BuildContext context) {
    _currTrack = tracks[_currPos];
    return FractionallySizedBox(
      widthFactor: 0.87,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CoverStack(
            tracks: tracks,
            current: _currPos,
          ),
          Row(children: [
            Column(children: [
              Text(
               _currTrack.name,
                style: CupertinoTheme.of(context).textTheme.textStyle
              ),
            ]),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            CupertinoButton.filled(
              child: Text('Prev',
                  style: CupertinoTheme.of(context).textTheme.textStyle),
              onPressed: () {
                if (_currPos > 0) {
                  _currPos -= 1;
                }
                setState(() {
                  _currTrack = tracks[_currPos];
                });
              },
            ),
            CupertinoButton.filled(
              child: Text('Next',
                  style: CupertinoTheme.of(context).textTheme.textStyle),
              onPressed: () {
                if (_currPos < tracks.length - 1) {
                  setState(() {
                    _currPos += 1;
                  });
                }
              },
            ),]
          )
        ])
    );
  }
}
