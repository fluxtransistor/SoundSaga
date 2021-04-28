import 'package:flutter/cupertino.dart';
import 'package:soundsaga/track.dart';


class CoverStack extends StatelessWidget {
  final tracks;
  var position;

  CoverStack({@required this.tracks, @required this.position});

  static const double rotFirst = 0.1;
  static const double rotChange = 0.08;
  static const int dispLimit = 5;


  var covers = <Widget>[];

  @override
  Widget build(BuildContext context) {
    int index = position.toInt();
    double extra = position - index;

    var coversRev = <Widget>[];

    for (var i = index; (i < (index + dispLimit)) && (i < tracks.length); i++) {
      double pos = (i - index - extra);
      double brightness = 1 / (pos + 1);
      double scale = 1 - (pos / 50);
      //double opacity = 1.0;
      double rotation = rotFirst + pos * rotChange;
      double yeet = 0;
      if (pos < 0) {
        brightness = 1.0;
        scale = 1 + extra;
        yeet = 500 * extra;
        rotation = rotFirst + -1 * extra;
        if (pos < -0.5) {
          // opacity = (1 - (extra - 0.5) * 2);
        }
      }
      coversRev.add(
        Transform.scale(
          scale: scale,
          child: Transform.translate(
            offset: Offset(pos*2, 0.0 - yeet),
            // child: Opacity(
            //  opacity: opacity,
              child: Cover(
                rotation: rotation,
                track: tracks[i],
                brightness: brightness,
              )
            //)
          )
        )
      );
    }
    covers = new List.from(coversRev.reversed);
    print(position);
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
