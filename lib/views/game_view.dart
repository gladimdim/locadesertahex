import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_surface.dart';
import 'package:locadesertahex/components/label_text.dart';
import 'package:locadesertahex/models/map_storage.dart';

class GameView extends StatefulWidget {
  GameView({Key key, this.title, this.map}) : super(key: key);
  final MapStorage map;
  final String title;

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final double size = 120;
  final double dimension = 6000;

  MapStorage map;

  void initState() {
    map = widget.map;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: map.changes,
          builder: (context, data) => Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: HexSurface(
                  dimension: dimension,
                  size: size,
                  storage: map,
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 32,
                    color: Colors.white.withAlpha(155),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            size: 24,
                            color: Colors.green[700],
                          ),
                          onPressed: () {
                            setState(() {
                              map = MapStorage.generate();
                            });
                          },
                        ),
                        LabelText(
                            "Points: ${map.totalPoints}"),
                        IconButton(
                          icon: Icon(
                            Icons.shuffle,
                            size: 24,
                            color: Colors.green[700],
                          ),
                          onPressed: () {
                            setState(() {
                              map.shuffle();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
