import 'dart:async';
import 'dart:math';

enum SizeEvent { sizeEvent }

class SizeBloc {
  int _width = 100;
  int get width => _width;
  int _height = 100;
  int get height => _height;

  final _inputEventController = StreamController<SizeEvent>();

  StreamSink<SizeEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<int>();

  Stream<int> get outputStateStream => _outputStateController.stream;

  void getSizeRandom() {
    _width = Random().nextInt(250);
    _height = Random().nextInt(250);
  }

  void _mapEventToState(SizeEvent event) {
    getSizeRandom();

    _outputStateController.sink.add(_width);
    _outputStateController.sink.add(_height);
  }

  SizeBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
