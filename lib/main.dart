import 'package:auth/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimeProvider>(
            create: (context) => TimeProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<TimeProvider>(context, listen: false).updateTime();
    super.initState();
  }

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHour = true;
  final _scrollcontroller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollcontroller.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Current Time Is",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              DateFormat('hh:mm:ss ')
                  .format(Provider.of<TimeProvider>(context).currentTime),
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 40,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Provider.of<TimeProvider>(context, listen: false).updateTime();
            //   },
            //   child: const Text('update'),
            // ),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final value = snapshot.data ;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value!, hours: _isHour );
                return Text(displayTime , style: const TextStyle(fontSize: 30));
              },
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      _stopWatchTimer.onStartTimer();
                    },
                    child: const Text('start')),
                const SizedBox(width: 40),
                ElevatedButton(
                    onPressed: () {
                      _stopWatchTimer.onStopTimer();
                    },
                    child: const Text('Stop'))
              ],
            ),
            const SizedBox(height: 40),
            StreamBuilder<List<StopWatchRecord>>(
              stream: _stopWatchTimer.records,
              initialData: _stopWatchTimer.records.value,
              builder: (context, snapshot) {
               final value =snapshot.data;
               if (value==null) {
                   return Container();
               }
               return ListView.builder(
                controller: _scrollcontroller,
                itemBuilder: (context, index) {
                  final data=value[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${index+1}--${data.displayTime}'),
                      )
                    ],
                  );

               },);
            },)
          ],
        ),
      ),
    );
  }
}
