import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:soundsaga/track.dart';

// ignore: must_be_immutable
class CoverStack extends StatefulWidget {
  var tracks = <Track> [];
  CoverStack({@required this.tracks});
  @override
  _CoverStackState createState() => _CoverStackState();
}

class _CoverStackState extends State<CoverStack> {
  static const double initialRotation = 0.1;
  static const double rotationDecrement = 0.08;
  var covers = <Widget> [];

  void createInitialState() {
    var coversTemp = <Widget> [];
    for (var i = 0; i < widget.tracks.length; i++) {
      var rotation = initialRotation - i * rotationDecrement;
      coversTemp.add(
        Transform.translate(
          offset: Offset(0.0, 0.0),
          child:
            Cover(
              rotation: rotation,
              track: widget.tracks[i],
              brightness: 1/(2*(i)+1),
            )
        )
      );
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
      child: Stack(
        children: covers,
      )
    );
  }
}

class Cover extends StatefulWidget {
  final Track track;
  final double rotation;
  final brightness;
  Cover({@required this.track, @required this.rotation, this.brightness});
  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(angle: widget.rotation,
        child: AspectRatio(aspectRatio:1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.50),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 0), // changes position of shadow
                ),],
            ),
            child: ClipRRect(
              child: imageShader(widget.track.img, widget.brightness),
            )
          )
        )
    );
  }
}

ShaderMask imageShader(Image image, double brightness) {
  if (brightness == null) {
    brightness = 1.0;
  }
  var val = (brightness * 255).round();
  const values = <int> [15,48,78,120];
  const stops = <double> [0, 0.4,0.8, 1.0];
  var colors = <Color> [];
  values.forEach((b) {colors.add(Color.fromARGB(255,b,b,b));});
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
