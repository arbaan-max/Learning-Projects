part of 'weather_api_bloc.dart';

@immutable
abstract class WeatherApiState extends Equatable {
  const WeatherApiState();

  @override
  List<Object> get props => [];
}

class WeatherApiInitial extends WeatherApiState {}

class WeatherApiLoading extends WeatherApiState {}

class WeatherApiLoaded extends WeatherApiState {
  final List<ApiModel> model;
  const WeatherApiLoaded(this.model);
}

class WeatherApiFailed extends WeatherApiState {
  final String? message;
  const WeatherApiFailed(this.message);
}
