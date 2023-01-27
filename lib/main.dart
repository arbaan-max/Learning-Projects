// This code is distributed under the MIT License.
// Copyright (c) 2019 Remi Rousselet.
// You can find the original at https://github.com/rrousselGit/provider.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This is a reimplementation of the default Flutter application
// using provider + [ChangeNotifier].
void main() {
  runApp(
    // Providers are above [MyApp] instead of inside it, so that
    // tests can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}



// Mix-in [DiagnosticableTreeMixin] to have access to
// [debugFillProperties] for the devtool ignore: prefer_mixin
class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  DateTime _now = DateTime.now();
   Duration _timer =const Duration();

  int get count => _count;
  Duration get time => _timer;
  
  void setTime(Duration time){
    _timer=time;
    notifyListeners();
  }
  
    Future<void> updateTime() async{
    while (true) {
      await Future.delayed(const Duration(seconds: 1), () {
      _now = DateTime.now();
        notifyListeners();
        return _now;
      
    });}
    }  
  
   void startTimer() async{
    while (_timer.inMinutes==0 && _timer.inSeconds==0) {
      await Future.delayed(const Duration(seconds: 1), () {
      _timer = Duration(minutes:_timer.inMinutes,seconds: _timer.inSeconds );        
      notifyListeners();
    });
      
    }
    
  }
  
  void increment() {
    _count++;
    notifyListeners();
  }

  // Makes `Counter` readable inside the devtools by listing all
  // of its properties.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}




class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      // Calls `context.watch` to make [Count] rebuild when
      // [Counter] changes.
      '${context.watch<Counter>().time}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerHour = TextEditingController();
    TextEditingController _controllerSeconds =TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Text('You have pushed the button this many times:'),
            const Count(),
      
              TextField(
            controller: _controllerHour,
            ),
            TextField(
            controller: _controllerSeconds,
            ),
        ElevatedButton(
        onPressed: (){
          context.read<Counter>().startTimer();
        },
          child: Text('Press me '),
        ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),
        onPressed: () => context.read<Counter>().setTime
        (Duration(minutes: int.parse(_controllerHour.text),
                  seconds: int.parse(_controllerSeconds.text))),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


