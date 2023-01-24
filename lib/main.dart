import 'package:auth/bloc/weather_api_bloc.dart';
import 'package:auth/services/weather_api.dart';
import 'package:auth/views/weather_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherApiBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const WeatherList()
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Api _api =Api();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _api.getapi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!.map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:Text( e.userId.toString()),
                    title: Text(e.id.toString()),
                    subtitle: Text(e.title),
                    onTap: (){},
                  ),
                )).toList(),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
