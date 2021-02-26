import 'dart:async';
import 'dart:collection';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:locadesertahex/components/resource_image_view.dart';
import 'package:locadesertahex/hexgrid/funcs.dart';
import 'package:locadesertahex/models/resources/resource.dart';

const NOTIFICATION_BAR_HEIGHT = 100.0 ;
class NotificationManager {
  Color colorSuccess = Colors.amber;
  Color colorError = Colors.red;

  NotificationManager._internal();

  num deltaOffset = 150;
  num offset = 0;
  static final NotificationManager instance = NotificationManager._internal();
  final Duration defaultDuration = Duration(milliseconds: 1200);
  Queue<Function> queue = Queue();
  Timer timer;

  void showNotification(Widget payload, [Color color = Colors.amber]) {
    payload = payload ?? Container();
    BotToast.showAttachedWidget(
      target: Offset(0, offset.toDouble() + 1),
      duration: defaultDuration,
      attachedBuilder: (_) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: NOTIFICATION_BAR_HEIGHT),
        child: Card(
          color: color,
          child: Padding(padding: const EdgeInsets.all(8.0), child: payload),
        ),
      ),
      preferDirection: PreferDirection.topCenter,
    );
  }

  void processNotificationWithResource(List<Resource> payload) {
    Widget widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: payload.map((resource) {
          return ResourceImageView(
            size: 42,
            resource: resource,
            showAmount: true,
          );
        }).toList());
    showNotification(
      widget,
    );
  }
}
