import 'dart:async';
import 'dart:math';

import 'package:block_test/bloc/color_block.dart';
import 'package:block_test/bloc/size_block.dart';
import 'package:flutter/material.dart';

enum Events { randomColor, sizeEvent, positioned }

class EventsBloc {
  Color _color = Colors.red;
  Color get color => _color;

  int _width = 100;
  int get width => _width;

  int _height = 100;
  int get height => _height;

  double? top;
  double? left;

/* input event controllers */
  final _inputColorEventController = StreamController<Events>();
  StreamSink<Events> get inputColorEventSink => _inputColorEventController.sink;

  final _inputSizeEventController = StreamController<Events>();
  StreamSink<Events> get inputSizeEventSink => _inputSizeEventController.sink;

  final _inputPositionedEventController = StreamController<Events>();
  StreamSink<Events> get inputPositionedEventSink =>
      _inputPositionedEventController.sink;

/*output controllers */

  final _outputColorStateController = StreamController<Color>();
  final _outputSizeStateController = StreamController<int>();
  final _outputPositionedStateController = StreamController<double?>();

/*stream*/

  Stream<Color> get outputColorStateStream =>
      _outputColorStateController.stream;
  Stream<int> get outputSizeStateStream => _outputSizeStateController.stream;
  Stream<double?> get outputPositionedStateStream =>
      _outputPositionedStateController.stream;

  void _mapEventToState(Events event) {
    if (event == Events.randomColor) {
      getColorRandom();
    } else if (event == Events.sizeEvent) {
      getSizeRandom();
    } else if (event == Events.positioned) {
      changePos();
    }

    _outputColorStateController.sink.add(_color);
    _outputSizeStateController.sink.add(_width);
    _outputSizeStateController.sink.add(_height);
    _outputPositionedStateController.add(top);
    _outputPositionedStateController.add(left);
  }

  EventsBloc() {
    _inputColorEventController.stream.listen(_mapEventToState);
    _inputSizeEventController.stream.listen(_mapEventToState);
    _inputPositionedEventController.stream.listen(_mapEventToState);
  }

  getColorRandom() {
    _color =
        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }

  changePos() {
    top = Random().nextInt(500).toDouble();
    left = Random().nextInt(500).toDouble();
  }

  void getSizeRandom() {
    _width = Random().nextInt(250);
    _height = Random().nextInt(250);
  }

  void dispose() {
    _inputColorEventController.close();
    _outputColorStateController.close();
    _inputSizeEventController.close();
    _outputSizeStateController.close();
    _inputPositionedEventController.close();
    _outputPositionedStateController.close();
  }
}
