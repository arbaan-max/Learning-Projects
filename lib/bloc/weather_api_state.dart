part of 'weather_api_bloc.dart';

@immutable
abstract class WeatherApiState {}

class WeatherApiInitial extends WeatherApiState {}
class WeatherApiLoading extends WeatherApiState {}
class WeatherApiLoaded extends WeatherApiState {
  final ApiModel model;
  WeatherApiLoaded(this.model);
}
class WeatherApiFailed extends WeatherApiState {}
