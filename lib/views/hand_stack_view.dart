import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/models/hex.dart';

class HandStackView extends StatelessWidget {
  final List<Hex> stack;
  final Hex selectedCard;
  final Function(Hex) onCardSelected;
  HandStackView({this.stack, this.selectedCard, this.onCardSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stack.map((hexCard) {
          return InkWell(
            child: Container(
              decoration: highlightDecor(hexCard),
              child: ResourceImageView(
                resource: hexCard.output,
                size: 32,
              ),
            ),
            onTap: () {
              onCardSelected(hexCard);
            },
          );
        }).toList());
  }

  BoxDecoration highlightDecor(Hex hexCard) {
    if (hexCard == selectedCard) {
      return BoxDecoration(
        color: Colors.green.withAlpha(200),
      );
    } else {
      return null;
    }
  }
}
