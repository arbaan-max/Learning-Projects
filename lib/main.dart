import 'package:auth/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  .format(Provider.of<TimeProvider>(context).get()),
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                Provider.of<TimeProvider>(context,listen: false).updateTime();
              },
              child: const Text('update'),
            ),
          ],
        ),
      ),
    );
  }
}
