import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

void sendVideo(String filename) async {
  final Uint8List data = await File(filename).readAsBytes();
  Dio dio = Dio();
  dio.putUri(Uri.parse("http://localhost:8080"), data: data);
}
