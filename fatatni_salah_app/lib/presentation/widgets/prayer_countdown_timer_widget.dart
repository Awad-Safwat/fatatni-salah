import 'dart:async';

import 'package:fatatni_salah_app/core/shared/functions.dart';
import 'package:flutter/material.dart';

class PrayerCountdownTimer extends StatefulWidget {
  final DateTime nextPrayerTime;

  const PrayerCountdownTimer({Key? key, required this.nextPrayerTime})
      : super(key: key);

  @override
  _PrayerCountdownTimerState createState() => _PrayerCountdownTimerState();
}

class _PrayerCountdownTimerState extends State<PrayerCountdownTimer> {
  late Timer _timer;
  late Duration _timeUntilNextPrayer;

  @override
  void initState() {
    super.initState();
    _calculateTimeUntilNextPrayer();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateTimeUntilNextPrayer() async {
    final now = DateTime.now();
    final difference = getNextPrayer()!.time.difference(now);

    setState(() {
      _timeUntilNextPrayer = difference;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_timeUntilNextPrayer.inSeconds <= 0) {
        // Timer has reached 0, update UI or take action accordingly
        _calculateTimeUntilNextPrayer();

        // _timer.cancel();
      } else {
        setState(() {
          _timeUntilNextPrayer =
              _timeUntilNextPrayer - const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time until ${getNextPrayer()!.title}: ${_timeUntilNextPrayer.inHours}:${_timeUntilNextPrayer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(_timeUntilNextPrayer.inSeconds % 60).toString().padLeft(2, '0')}',
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
