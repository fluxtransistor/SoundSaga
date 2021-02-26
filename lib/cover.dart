import 'package:flutter/cupertino.dart';

// Widget coverStack(Track[] tracks)

ShaderMask imageShader(Image image) {
  return ShaderMask(
    child: image,
    blendMode: BlendMode.screen,
    shaderCallback: (Rect bounds) {
      return RadialGradient(
        center: Alignment.bottomRight,
        radius: 1.5,
        colors: [Color(0x00000000),Color(0xFFFFFFFF)],
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
  return new Stack(
      children: <Widget>[
        Center(
          child:
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
        ),
        Center(
          child:
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
        ),
        Center(
          child:
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
        ),
      ]
  );
}