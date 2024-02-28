import 'package:flutter/cupertino.dart';

class ElavatedRadius {
  static OutlinedBorder elevatedRadius(double borradius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borradius),
      ),
    );
  }
}
