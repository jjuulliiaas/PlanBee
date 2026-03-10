import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _secondsRemaining = 0;
  int _totalTime = 0;
  int _actualSecondsElapsed = 0;
  bool _isRunning = false;

  int get secondsRemaining => _secondsRemaining;
  bool get isRunning => _isRunning;
  double get progress => _totalTime == 0 ? 0 : _secondsRemaining / _totalTime;

  String get formattedTime {
    int mins = _secondsRemaining ~/ 60;
    int secs = _secondsRemaining % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void startTimer(int minutes) {
    _timer?.cancel();
    _secondsRemaining = minutes * 60;
    _totalTime = minutes * 60;
    _actualSecondsElapsed = 0;
    _resumeTimer();
  }

  void togglePause() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    } else if (_secondsRemaining > 0) {
      _resumeTimer();
    }
    notifyListeners();
  }

  void _resumeTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        _actualSecondsElapsed++;
        notifyListeners();
      } else {
        _timer?.cancel();
        _isRunning = false;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    _secondsRemaining = 0;
    _totalTime = 0;
    notifyListeners();
  }

  int getAndResetElapsed() {
    int elapsed = _actualSecondsElapsed;
    _actualSecondsElapsed = 0;
    return elapsed;
  }
}