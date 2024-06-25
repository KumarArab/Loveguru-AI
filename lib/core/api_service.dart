import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loveguru_ai/utils/app_exceptions.dart';

class ApiService {
  static final Dio dio = Dio();

  static const String pathPrefix = "https://api.openai.com/v1/";

  static Future<dynamic> getData(
    final String path, {
    Map<String, dynamic>? body,
    Map<String, String>? head,
    Map<String, dynamic>? queryParams,
  }) async {
    var responseJson;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer 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",
        if (head != null) ...head
      };

   
      String finalPath = pathPrefix + path;

      final queryString = Uri(queryParameters: queryParams).query;
      finalPath += '?$queryString';

      final response = await dio.get(
        finalPath,
        options: Options(headers: headers),
        data: body,
      );
      log("""
        💡 method: GET
        💡 endpoint: $finalPath\n
        💡 headers: $headers,
        💡 response: ${response.data}
        """);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
        'Error communication with server: Please check your internet connectivity',
      );
    } finally {}
    return responseJson;
  }

  static Future<dynamic> postData(
    final String path, {
    Map<String, dynamic>? body,
    Map<String, String>? head,
    Map<String, dynamic>? queryParams,
  }) async {
    var responseJson;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer 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",
        if (head != null) ...head
      };

      String finalPath = pathPrefix + path;

      final queryString = Uri(queryParameters: queryParams).query;
      finalPath += '?$queryString';

      final response = await dio.post(
        finalPath,
        options: Options(headers: headers),
        data: body,
      );
      log("""
        💡 method: POST
        💡 endpoint: $finalPath\n
        💡 headers: $headers,
        💡 response: ${response.data}
        """);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
        'Error communication with server: Please check your internet connectivity',
      );
    } finally {}
    return responseJson;
  }

  static dynamic returnResponse(Response response) {
    var responseJson = response.data;

    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson['message']);
      case 401:
      case 403:
        throw UnauthorizedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(responseJson["message"]);
    }
  }
}
