import 'dart:math';

import 'package:flutter/cupertino.dart';
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
  bool animating = false;

  Animation<double> animation;
  AnimationController controller;

  void animate(bool forward) {
    if (!animating && ((forward && _currIndex < tracks.length - 1)
        || (!forward && _currIndex > 0))) {
      setState(() {
        if (forward) {
          _currIndex += 1;
          _currPos = _currIndex - 1.0;
        } else {
          _currIndex -= 1;
          _currPos = _currIndex + 0.0;
        }
      });
      animating = true;
      controller =
          AnimationController(
              duration: const Duration(milliseconds: 500), vsync: this);
      animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
        ..addListener(() {
          setState(() {
            if (forward) {
              _currPos = _currIndex - 1.0 + animation.value;
            } else {
              _currPos = _currIndex + animation.value;
            }
          });
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animating = false;
          }
        });
      if (forward) {
        controller.forward(from: 0.0);
      } else {
        controller.reverse(from: 1.0);
      }
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
      onVerticalDragEnd: (details) {
        print(details.primaryVelocity);
        if (details.primaryVelocity > 0) {
            animate(false);
            print('back');
        } if (details.primaryVelocity < 0) {
            animate(true);
            print('fwd');
        }
      }
    );
  }
}
