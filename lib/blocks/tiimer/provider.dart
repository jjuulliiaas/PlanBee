import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _secondsRemaining = 0;
  int _totalTime = 0;
  bool _isRunning = false;

  int get secondsRemaining => _secondsRemaining;
  bool get isRunning => _isRunning;
  double get progress => _totalTime == 0 ? 0 : _secondsRemaining / _totalTime;




}