import 'package:flutter/cupertino.dart';

class TimeProvider extends ChangeNotifier {
  DateTime _now = DateTime.now();

  DateTime get() {
    return _now;
  }

  void updateTime() async{
    while (true) {
      await Future.delayed(const Duration(seconds: 1), () {
      _now = DateTime.now();
      notifyListeners();
    });
    }
    
  }
}
