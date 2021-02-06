import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/models/resources/resource.dart';

class ResourceImageView extends StatelessWidget {
  final Resource resource;
  final bool showAmount;
  final double size;
  final Color color;
  ResourceImageView(
      {@required this.resource, this.showAmount = false, this.size = 92, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          resource.toImagePath(),
          width: size,
          color: color,
        ),
        if (showAmount) Text(resource.value.toString()),
      ],
    );
  }
}
