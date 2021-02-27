import 'package:flutter/cupertino.dart';
import 'package:soundsaga/track.dart';

class CoverStack extends StatefulWidget{
  @override
  _CoverStackState createState() => _CoverStackState();
}

class _CoverStackState extends State<CoverStack> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

ShaderMask imageShader(Image image) {
  return ShaderMask(
    child:
      ShaderMask(
      child: image,
      blendMode: BlendMode.screen,
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.bottomRight,
          radius: 1.414,
          colors: [Color.fromARGB(255, 0,0,0),Color.fromARGB(255, 127,127,127),Color.fromARGB(255,180,180,180)],
          stops: [
            0.0,
            0.8,
            1.0,
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      ),
    blendMode: BlendMode.multiply,
    shaderCallback: (Rect bounds) {
      return RadialGradient(
        center: Alignment.bottomRight,
        radius: 1.414,
        colors: [Color.fromARGB(127, 0,0,0),Color.fromARGB(0,255,255,255)],
        stops: [
          0.0,
          1.0,
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
  );
}



Widget legacyStack() {
  return new Container( child: Stack(
      children: <Widget>[
        Transform.rotate(angle: 0.08,
            child:
            SizedBox(
              width: 280.00,
              height: 280.00,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 80, 80, 80),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.rotate(angle: 0.01,
            child:
            SizedBox(
              width: 280.00,
              height: 280.00,
              child: const DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 127, 127, 127),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.rotate(angle: -0.06,
            child:
            SizedBox(
              width: 280.00,
              height: 280.00,
              child: DecoratedBox(
                child:
                ClipRRect(child:
                  imageShader(Image(image: AssetImage("assets/life.jpeg"))),
                  borderRadius: BorderRadius.all(Radius.circular(5)),),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 127, 127, 127),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
      ]
  ));
}