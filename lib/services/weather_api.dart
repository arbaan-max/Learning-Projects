
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:auth/constant/uri_constant.dart';
import 'package:auth/model/weather_output.dart';

Future<List<Welcome>> getapi() async{
  Uri uri = Uri.parse(ApiUrl.wheatherApi);
  final client = http.Client();
  
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    return welcomeFromJson(response.body); 
  } else {
    throw Exception('Failed to load stations');
  }

}