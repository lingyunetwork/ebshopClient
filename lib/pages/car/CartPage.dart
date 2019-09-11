import 'package:flutter/material.dart';

import 'CartBottomWidget.dart';

class CarPage extends StatefulWidget {
  CarPage({Key key}) : super(key: key);

  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            width: 750,
            child: CartBottomWidget(),
          ),
        ],
      ),
    );
  }
}
