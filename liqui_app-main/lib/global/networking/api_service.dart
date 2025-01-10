import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';

import '../constants/index.dart';
import 'api_path.dart';
import 'custom_exception.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    //printLog("Base service initialised");

    ///add baseURL
    httpClient.baseUrl = baseUrl;

    ///add contentType
    httpClient.defaultContentType = "application/json";

    ///add timeout
    httpClient.timeout = const Duration(seconds: 15);

    ///add request [exe when request is being made]
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers['Authorization'] = 'Bearer ${myLocal.authToken}';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      request.headers['app-os'] = myHelper.osType;
      request.headers['device-unique-id'] = myLocal.deviceUniqueId;
      request.headers['app-version'] = await myHelper.appVersion;
      request.headers['app-build-number'] = await myHelper.appBuildNumber;
      if (myLocal.authToken.validString) {
        // log("Auth token: ${myLocal.authToken}");
      }
      // log('headers -> ${jsonEncode(request.headers)}');
      return request;
    });

    ///add headers
    // httpClient.addAuthenticator<dynamic>((request) async {
    //   var headers = {'Authorization': 'Bearer ${myLocal.authToken}'};
    //   request.headers.addAll(headers);
    //   return request;
    // });

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
    return responseHandler(endpoint, response);
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
    return responseHandler(endpoint, response);
  }

  dynamic responseHandler(String url, Response response) {
    log('$url response:------> ${jsonEncode(response.body)} with status code ${response.statusCode ?? "null"}');
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return response.body;
      case 400:
        throw BadRequestException(resourceErrorMessage);
      case 401:
        if (Get.currentRoute != otpScreen && url != postAppConfigUrl) {
          myHelper.logoutUser();
          break;
        } else {
          throw UnauthorisedException(unauthorizedMessage);
        }
      case 403:
        throw InvalidInputException(invalidRequestMessage);
      case 500:
        throw CatchException(serverErrorMessage);
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}

final apiService = Get.put(ApiService());
