import '../services/weather_api.dart';
import 'package:auth/model/weather_output.dart';

class ApiRepository {
  final _api = Api();
  Future<List<ApiModel>> fetchList() {
    return _api.getapi();
  }
}

class NetworkError extends Error {}
