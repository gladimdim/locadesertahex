import 'package:flutter/material.dart';
import 'package:locadesertahex/components/image_fitter_view.dart';

class ScaffoldWithMapBackground extends StatelessWidget {
  final Widget child;

  ScaffoldWithMapBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ImageFitterView(
          "images/background/map_bw.png",
        ),
        SafeArea(child: child),
      ]),
    );
  }
}
