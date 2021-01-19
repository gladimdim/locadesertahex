import 'package:flutter/material.dart';
import 'package:locadesertahex/models/resources/resource.dart';

class ResourceImageView extends StatelessWidget {
  final Resource resource;
  final bool showAmount;

  ResourceImageView({@required this.resource, this.showAmount = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          resource.toIconPath(),
          width: 22,
        ),
        if (showAmount)
          Text(
            '${resource.value}',
          ),
      ],
    );
  }
}
