import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resized_image.dart';

class ImageFitterView extends StatelessWidget {
  final String path;

  ImageFitterView(this.path);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ResizedImage(
        path,
        // fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: orientation == Orientation.portrait
            ? BoxFit.fitHeight
            : BoxFit.fitWidth,
      );
    });
  }
}
