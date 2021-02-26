import 'package:flutter/cupertino.dart';

// Widget coverStack(Track[] tracks)

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
              child: const DecoratedBox(
                child:
                ClipRRect(child: Image(image: AssetImage('assets/dsotm.jpg')),
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