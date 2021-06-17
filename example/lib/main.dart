import 'package:flutter/material.dart';
import 'dart:async';

import 'package:loop_health_flutter/loop_health_flutter.dart';
import 'package:loop_health_flutter/stored_glucose_sample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<StoredGlucoseSample> _samples = List.from([]);

  @override
  void initState() {
    super.initState();
    retrieveGlucoseSamples();
  }

  Future<void> retrieveGlucoseSamples() async {
    List<StoredGlucoseSample> samples;
    samples = await LoopHealthFlutter.getGlucoseSamples();

    setState(() {
      _samples = samples;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('loop_health_flutter example app'),
        ),
        body: Center(
          child: Text(_samples.isNotEmpty
              ? 'Most recent glucose sample: ${_samples.last.quantity} at ${_samples.last.timestamp}\n'
              : 'Could not retrieve glucose samples'),
        ),
      ),
    );
  }
}
