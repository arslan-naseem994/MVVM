import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/base_api_service.dart';

class NetworkApiService extends BaseApiServices {
  //// getApi
  @override
  Future getGetApiResponse(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet');
    }

    return responseJson;
  }

  ///// postApi
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet');
    }

    return jsonResponse;
  }

  //// status code validation
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJosn = jsonDecode(response.body);
        return responseJosn;
      case 400:
        throw BadRequestExceptions(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataExceptions(
            'Error occured while communicating with servder with status code: ${response.statusCode.toString()}');
    }
  }
}
