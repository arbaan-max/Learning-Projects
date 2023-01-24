import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_api_bloc.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({super.key});

  @override
  State<WeatherList> createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  final WeatherApiBloc _newsBloc = WeatherApiBloc();
  @override
  void initState() {
    _newsBloc.add(GetList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather List')),
      body: Container(
          margin: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => _newsBloc,
            child: BlocListener<WeatherApiBloc, WeatherApiState>(
              listener: (context, state) {
                if (state is WeatherApiFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              child:BlocBuilder(builder: (context, state) {
                if(state is WeatherApiInitial){
                  return const Center(child: CircularProgressIndicator(),);
                }else if(state is WeatherApiFailed){
                  return const Center(child: Text("Failed to Load"),);
                }else if(state is WeatherApiLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }else if(state is WeatherApiLoaded){
                  return ListView.builder(
                    itemCount: state.model.length,
                    itemBuilder: (context, index) {
                    return Card(
                      child:ListTile(
                        title: Text(state.model[index].title),
                        subtitle: Text(state.model[index].body),
                      ) ,
                      );
                  },);
                }else{
                  return Container();
                }
              }
              ,) ,
            ),
          )),
    );
  }
}
