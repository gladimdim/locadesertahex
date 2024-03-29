import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResizedImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;

  const ResizedImage(this.imagePath,
      {Key key, this.width, this.height, this.fit, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int width2 = width == null ? null : width.toInt();
    int height2 = height == null ? null : height.toInt();
    return kIsWeb
        ? Image.asset(imagePath, width: width, height: height, color: color,)
        : Image(
            fit: fit,
            image: ResizeImage(
              AssetImage(imagePath),
              width: width2,
              height: height2,
            ),
          );
  }
}
