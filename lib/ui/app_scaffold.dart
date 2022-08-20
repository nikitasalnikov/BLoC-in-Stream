import 'dart:math';

import 'package:block_test/bloc/color_block.dart';
import 'package:block_test/bloc/events_bloc.dart';
import 'package:block_test/bloc/size_block.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final EventsBloc _eventsBloc = EventsBloc();

  @override
  void dispose() {
    _eventsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC in Stream'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
          stream: _eventsBloc.outputPositionedStateStream,
          initialData: [
            _eventsBloc.color,
            _eventsBloc.height,
            _eventsBloc.left,
            _eventsBloc.top,
          ],
          builder: (context, snapshot) {
            return Stack(
              children: [
                Positioned(
                  top: _eventsBloc.top,
                  left: _eventsBloc.left,
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      color: _eventsBloc.color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    duration: const Duration(milliseconds: 500),
                    width: _eventsBloc.width.toDouble(),
                    height: _eventsBloc.height.toDouble(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          FloatingActionButton(
            onPressed: () {
              _eventsBloc.inputColorEventSink.add(Events.randomColor);
            },
            backgroundColor: Colors.red,
            child: const Text('Color'),
          ),
          const SizedBox(width: 25),
          FloatingActionButton(
            onPressed: () {
              _eventsBloc.inputSizeEventSink.add(Events.sizeEvent);
            },
            backgroundColor: Colors.green,
            child: const Text('Size'),
          ),
          const SizedBox(width: 25),
          FloatingActionButton(
            onPressed: () {
              _eventsBloc.inputPositionedEventSink.add(Events.positioned);
            },
            backgroundColor: Colors.blue,
            child: const Text(
              'Position',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
