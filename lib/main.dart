import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: ClipPath(
                child: InkWell(
                  child: CustomPaint(
                    // child: Container(color: Colors.blue),
                    foregroundPainter: HexPainter(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    print("lol");
                  },
                ),
                clipper: const HexClipper(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  Path getWheelPath(double wheelSize, double fromRadius, double toRadius) {
    return new Path()
      ..moveTo(wheelSize, wheelSize)
      ..arcTo(
          Rect.fromCircle(
              radius: wheelSize, center: Offset(wheelSize, wheelSize)),
          fromRadius,
          toRadius,
          false)
      ..close();
  }

  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double wheelSize = 100;
    double nbElem = 6;
    double radius = (2 * pi) / nbElem;

    canvas.drawPath(
        getWheelPath(wheelSize, 0, radius), getColoredPaint(Colors.red));
    canvas.drawPath(getWheelPath(wheelSize, radius, radius),
        getColoredPaint(Colors.purple));
    canvas.drawPath(getWheelPath(wheelSize, radius * 2, radius),
        getColoredPaint(Colors.blue));
    canvas.drawPath(getWheelPath(wheelSize, radius * 3, radius),
        getColoredPaint(Colors.green));
    canvas.drawPath(getWheelPath(wheelSize, radius * 4, radius),
        getColoredPaint(Colors.yellow));
    canvas.drawPath(getWheelPath(wheelSize, radius * 5, radius),
        getColoredPaint(Colors.orange));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
