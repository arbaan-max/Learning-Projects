import 'package:auth/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

void main() {
  runApp(MyApp());
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

  TextEditingController timeinput = TextEditingController();

  String? _selectedTime;  

    Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
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
              Text(
          _selectedTime != null ? _selectedTime! : 'No time selected!',
          style: const TextStyle(fontSize: 30),
        ),
        
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: _show, child: const Text('Show Time Picker')),
    );
  }
}
