import 'package:flutter/cupertino.dart';
import 'package:soundsaga/track.dart';

class CoverStackController {
  void Function(int i) goto;
}

class CoverStack extends StatefulWidget {
  final tracks;

  final current;

  CoverStack({@required this.tracks, this.current});

  @override
  _CoverStackState createState() => _CoverStackState(current);
}

class _CoverStackState extends State<CoverStack> {
  static const double initialRotation = 0.1;
  static const double rotationDecrement = 0.08;
  static const int displayLimit = 4;
  var _current;

  void goto(int i) {
    setState(() {
      first = i;
      createInitialState();
    });
  }

  _CoverStackState(int _current_t) {
    _current = _current_t;
  }

  var covers = <Widget>[];
  var first = 0;

  void createInitialState() {
    first = _current;
    var coversTemp = <Widget>[];
    if (first >= widget.tracks.length) {
      first = widget.tracks.length - 1;
    }
    var limit;
    if ((first + displayLimit) >= widget.tracks.length) {
      limit = widget.tracks.length;
    } else {
      limit = first + displayLimit;
    }
    for (var i = first; i < limit; i++) {
      var rotation = initialRotation - (i - first) * rotationDecrement;
      coversTemp.add(Transform.translate(
          offset: Offset(1.0 * (i - first), 0.0),
          child: Cover(
            rotation: rotation,
            track: widget.tracks[i],
            brightness: 1 / ((i - first) + 1),
          )));
    }
    covers = new List.from(coversTemp.reversed);
  }

  @override
  Widget build(BuildContext context) {
    createInitialState();
    return Padding(
        padding: EdgeInsets.all(24.0),
        child: Stack(
          children: covers,
        ));}
}

class Cover extends StatelessWidget {
  final Track track;
  final double rotation;
  final brightness;

  Cover({@required this.track, @required this.rotation, this.brightness});

  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: rotation,
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
