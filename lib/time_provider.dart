import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimeProvider extends ChangeNotifier {
  DateTime _now = DateTime.now();
  Duration _timer =Duration();
  String? _selectedTime; 

  DateTime get currentTime {
    return _now;
  }

  Duration get strat{
    return _timer;
  }

  void updateTime() async{
    while (true) {
      await Future.delayed(const Duration(seconds: 1), () {
      _now = DateTime.now();
      notifyListeners();
    });
    }
    
  }

  void setTime(Duration time){
    _timer=time;
    notifyListeners();
  }

 void startTimer() async{
    while (_timer.inMinutes==0 && _timer.inSeconds==0) {
      await Future.delayed(const Duration(seconds: 1), () {
      _timer = Duration(minutes:_timer.inMinutes,seconds: _timer.inSeconds-1);
      notifyListeners();
    });
    }
    
  }

}
