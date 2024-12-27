import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  final VoidCallback onTimerEnd;

  const TimerPage({Key? key, required this.onTimerEnd}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer;
  int _start = 15; // Example countdown time in seconds

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        widget.onTimerEnd();
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_start',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
