import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<List<int>> sendVideo(Uint8List bytes) async {
  Dio dio = Dio();
  var response =
      await dio.putUri(Uri.parse("http://10.0.2.2:5000/"), data: bytes);
  int carCount = response.data["carCount"];
  int busCount = response.data["busCount"];
  int bicycleCount = response.data["bicycleCount"];
  int truckCount = response.data["truckCount"];
  return [carCount, busCount, bicycleCount, truckCount];
}
