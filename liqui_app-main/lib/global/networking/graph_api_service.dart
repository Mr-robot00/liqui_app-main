import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';

import '../constants/index.dart';
import 'api_path.dart';
import 'api_service.dart';
import 'custom_exception.dart';

class GraphApiService extends GetConnect {
  @override
  void onInit() {
    // printLog("Base service initialised");

    ///add baseURL
    httpClient.baseUrl = cmsBaseUrl;

    ///add contentType
    httpClient.defaultContentType = "application/json";

    ///add timeout
    httpClient.timeout = const Duration(seconds: 15);

    ///add request [exe when request is being made]
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers['Authorization'] = 'Bearer $graphQLToken';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });

    /// add max retry
    httpClient.maxAuthRetries = 3;
  }

  /// call get request
  Future<dynamic> getRequest(String endpoint,
      {Map<String, dynamic>? query}) async {
    log('$endpoint: query -> ${jsonEncode(query)}');
    if (!await myHelper.hasNetwork) {
      throw FetchDataException("no_internet_message".tr);
    }
    Response response;
    try {
      response = await get(endpoint, query: query)
          .timeout(const Duration(seconds: 15));
    } on TimeoutException {
      throw FetchDataException("request_timeout_message".tr);
    }
    return apiService.responseHandler(endpoint, response);
  }

  /// call post request
  Future<dynamic> postRequest(String endpoint, dynamic body) async {
    log('$endpoint: body -> ${jsonEncode(body)}');
    if (!await myHelper.hasNetwork) {
      throw FetchDataException("no_internet_message".tr);
    }
    Response response;
    try {
      response =
          await post(endpoint, body).timeout(const Duration(seconds: 15));
    } on TimeoutException {
      throw FetchDataException("request_timeout_message".tr);
    }
    return apiService.responseHandler(endpoint, response);
  }
}

final graphApiService = Get.put(GraphApiService());
