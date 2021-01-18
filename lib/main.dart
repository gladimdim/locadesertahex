import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_clipper.dart';
import 'dart:math';

import 'package:locadesertahex/components/hex_surface.dart';

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
  final double size = 50;
  final double dimension = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HexSurface(
          dimension: dimension,
          size: size,
        ),
      ),
    );
  }
}

