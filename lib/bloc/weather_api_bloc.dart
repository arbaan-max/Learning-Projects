import 'package:auth/model/weather_output.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weather_api_event.dart';
part 'weather_api_state.dart';

class WeatherApiBloc extends Bloc<WeatherApiEvent, WeatherApiState> {
  WeatherApiBloc() : super(WeatherApiInitial()) {
    on<WeatherApiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
