import 'package:flutter/cupertino.dart';
import 'package:soundsaga/track.dart';

class CoverStack extends StatelessWidget {
  final tracks;

  final position;

  CoverStack({@required this.tracks, @required this.position});

  static const double rotFirst = 0.1;
  static const double rotChange = 0.08;
  static const int displayLimit = 5;

  @override
  Widget build(BuildContext context) {
    int index = position.toInt();
    double extra = position - index;
    int last = index + displayLimit - 1;
    if (index + displayLimit > tracks.length) {
      last = tracks.length - 1;
    }
    var covers = <Widget>[];
    for (var i = last; i >= index; i--) {
      double pos = (i - index - extra);
      double brightness = 1 / (pos + 1);
      double scale = 1 - (pos / 50);
      //double opacity = 1.0;
      double rotation = rotFirst + pos * rotChange;
      double yeet = 0;
      double spread = 1;
      if (pos < 0) {
        brightness = 1.0;
        scale = 1 + extra;
        yeet = 400 * extra;
        rotation = rotFirst + -1 * extra;
        spread = 1 + 10 * extra;
        if (pos < -0.5) {
          // opacity = (1 - (extra - 0.5) * 2);
        }
      }
      double blur = 8 * spread;
      covers.add(Transform.scale(
          scale: scale,
          child: Transform.translate(
              offset: Offset(pos * 2 - yeet * 0.3, 0.0 - yeet),
              // child: Opacity(
              //  opacity: opacity,
              child: Cover(
                rotation: rotation,
                track: tracks[i],
                brightness: brightness,
                blurSpread: spread,
                blurRadius: blur,
              )
              //)
              )));
    }
    return Padding(
        padding: EdgeInsets.all(24.0),
        child: Stack(
          children: covers,
        ));
  }
}

class Cover extends StatelessWidget {
  final Track track;
  final double rotation;
  final brightness;
  final blurRadius;
  final blurSpread;

  Cover({@required this.track, @required this.rotation, @required this.brightness, @required this.blurRadius, @required this.blurSpread});

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
                      spreadRadius: this.blurSpread,
                      blurRadius: this.blurRadius,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: imageShader(track.img, brightness),
                  //child: track.img
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
