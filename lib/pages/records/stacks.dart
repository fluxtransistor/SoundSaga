import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:soundsaga/track.dart';

class CoverStackController {
  void Function() next;
}

class CoverStack extends StatefulWidget {
  final tracks;
  final CoverStackController controller;

  CoverStack({@required this.tracks, this.controller});

  @override
  _CoverStackState createState() => _CoverStackState(controller);
}

class _CoverStackState extends State<CoverStack> {
  static const double initialRotation = 0.1;
  static const double rotationDecrement = 0.08;
  static const int displayLimit = 4;

  void setFirst(int i) {
    first = i;
    createInitialState();
  }

  void next() {
    setState(() {
      first += 1;
      createInitialState();
    });
  }

  _CoverStackState(CoverStackController _controller) {
    _controller.next = next;
  }

  var covers = <Widget>[];
  var first = 0;

  void createInitialState() {
    var coversTemp = <Widget>[];
    var limit;
    if ((first + displayLimit) > widget.tracks.length) {
      limit = widget.tracks.length;
    } else {
      limit = first + displayLimit;
    }
    print("state init " + first.toString());
    for (var i = first; i < limit; i++) {
      var rotation = initialRotation - i * rotationDecrement;
      coversTemp.add(Transform.translate(
          offset: Offset(1.0 * i, 0.0),
          child: Cover(
            rotation: rotation,
            track: widget.tracks[i],
            brightness: 1 / (i + 1),
          )));
    }
    covers = new List.from(coversTemp.reversed);
  }

  @override
  Widget build(BuildContext context) {
    if (covers.length == 0) {
      createInitialState();
    }
    return FractionallySizedBox(
        widthFactor: 0.85,
        child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Stack(
              children: covers,
            )));
  }
}

class Cover extends StatefulWidget {
  var track;
  final double rotation;
  final brightness;

  Cover({@required this.track, @required this.rotation, this.brightness});
  _CoverState createState() => _CoverState(this.track,this.rotation,this.brightness);

}

class _CoverState extends State<Cover> with SingleTickerProviderStateMixin {

  _CoverState(Track track, double rotation, brightness);


  static const double rotationDecrement = 0.08;
  Animation<double> animation;
  AnimationController controller;


  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: rotation - animation.value,
        child: AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: imageShader(track.img, brightness),
                ))));
  }
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation =
    Tween<double>(begin: 0, end: rotationDecrement).animate(controller)
      ..addListener(() {
        setState(() {

        });
      });
    controller.forward();
  }
}
}

ShaderMask imageShader(Image image, double brightness) {
  if (brightness == null) {
    brightness = 1.0;
  }
  var val = (brightness * 255).round();
  const values = <int>[15, 48, 78, 120];
  const stops = <double>[0, 0.4, 0.8, 1.0];
  var colors = <Color>[];
  values.forEach((b) {
    colors.add(Color.fromARGB(255, b, b, b));
  });
  return ShaderMask(
    child: ShaderMask(
      child: image,
      blendMode: BlendMode.screen,
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.bottomRight,
          radius: 1.414,
          colors: colors,
          stops: stops,
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
    ),
    blendMode: BlendMode.multiply,
    shaderCallback: (Rect bounds) {
      return RadialGradient(
        center: Alignment.bottomRight,
        radius: 1.414,
        colors: [
          Color.fromARGB(255, val, val, val),
          Color.fromARGB(255, val, val, val)
        ],
        stops: [
          0.0,
          1.0,
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
  );
}
