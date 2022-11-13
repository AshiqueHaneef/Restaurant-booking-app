import 'package:flutter/material.dart';

extension AlignUtils on BuildContext {
  Size screenSize() {
    return MediaQuery.of(this).size;
  }
}
