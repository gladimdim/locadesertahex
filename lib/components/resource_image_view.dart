import 'package:flutter/material.dart';
import 'package:locadesertahex/components/label_text.dart';
import 'package:locadesertahex/models/resources/resource.dart';

class ResourceImageView extends StatelessWidget {
  final Resource resource;
  final bool showAmount;
  final double size;

  ResourceImageView(
      {@required this.resource, this.showAmount = false, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          resource.toImagePath(),
          width: size,
        ),
        if (showAmount)
          LabelText(resource.value.toString()),

      ],
    );
  }
}
