import 'package:auth/model/weather_output.dart';
import 'package:auth/repository/weather_repo.dart';
import 'package:auth/services/weather_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_api_event.dart';
part 'weather_api_state.dart';

class WeatherApiBloc extends Bloc<WeatherApiEvent, WeatherApiState> {
  WeatherApiBloc() : super(WeatherApiInitial()) {
    final Api _api = Api();
    on<WeatherApiEvent>((event, emit) async {
      try {
        emit(WeatherApiLoading());
        final weatherList = await _api.getapi();
        emit(WeatherApiLoaded(weatherList));
      } on NetworkError {
        emit(const WeatherApiFailed('There is an Error'));
      }
    });
  }
}
