import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:soundsaga/pages/records/stacks.dart';
import 'package:soundsaga/track.dart';


class SingleRecordPage extends StatefulWidget {
  @override
  SingleRecordPageState createState() => SingleRecordPageState();
}

class SingleRecordPageState extends State<SingleRecordPage> with TickerProviderStateMixin {
  var tracks = [
    DemoTrack1(),
    DemoTrack2(),
    DemoTrack1(),
    DemoTrack2(),
  ];

  int _currIndex = 0;
  double _currPos = 0.0;

  Animation<double> animation;
  AnimationController controller;

  void animateNext() {
    if (_currIndex < tracks.length - 1) {
      setState(() {
        _currIndex += 1;
      });
      controller =
          AnimationController(
              duration: const Duration(milliseconds: 500), vsync: this);
      animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
        ..addListener(() {
          setState(() {
            _currPos = _currIndex - 1 + animation.value;
          });
        });
      controller.forward();
    }
  }
  void animatePrev() {
    if (_currIndex > 0) {
      setState(() {
        _currIndex -= 1;
      });
      controller =
          AnimationController(
              duration: const Duration(milliseconds: 500), vsync: this);
      animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
        ..addListener(() {
          setState(() {
            _currPos = _currIndex + 1 - animation.value;
          });
        });
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {

    var ui = FractionallySizedBox(
      widthFactor: 0.87,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CoverStack(
            tracks: tracks,
            position: _currPos,
          ),
          Row(children: [
            Column(children: [
              Text(
               tracks[_currIndex].name,
                style: CupertinoTheme.of(context).textTheme.textStyle
              ),
            ]),
          ]),
        ])
    );
    return GestureDetector(
      child: ui,
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity > 0) {
          animateNext();
        };
        if (details.primaryVelocity < 0) {
          animatePrev();
        };
      }
    );
  }
}
