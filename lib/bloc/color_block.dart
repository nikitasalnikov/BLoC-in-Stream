import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum ColorEvent { eventRed }

class ColorBlock {
  Color _color = Colors.red;
  Color get color => _color;

  final _inputEventController = StreamController<ColorEvent>();

  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<Color>();

  Stream<Color> get outputStateStream => _outputStateController.stream;

  getColorRandom() {
    _color =
        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }

  void _mapEventToState(ColorEvent event) {
    getColorRandom();

    _outputStateController.sink.add(_color);
  }

  ColorBlock() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
