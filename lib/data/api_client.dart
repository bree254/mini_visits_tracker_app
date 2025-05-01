import 'dart:ui';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_flutter_starter_shell/core/constants/api_constants.dart';
import 'package:my_flutter_starter_shell/data/models/activities/activity_response.dart';
import 'package:my_flutter_starter_shell/data/models/customers/customer_response.dart';
import 'package:my_flutter_starter_shell/data/models/visits/visits_response.dart';

import '../../core/app_export.dart';
import '../core/theme/app_text_styles.dart';
import '../core/utils/logger.dart';
import 'endpoints.dart';
import 'network_interceptors.dart';

class ApiClient extends GetConnect {
  final _dio = dio.Dio(dio.BaseOptions(connectTimeout: const Duration(seconds: 3)));

  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _dio.interceptors.add(dio.LogInterceptor());
    _dio.interceptors.add(NetworkInterceptor());

    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        Get.dialog(
          AlertDialog(
            title: Text(
              'Network Error',
              style: TextStyle(color: appTheme.error),
            ),
            content: const Text('Please ensure your internet connection is stable.'),
            backgroundColor: Theme.of(Get.context!).brightness == Brightness.light
                ? appTheme.white
                : appTheme.white,
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: appTheme.colorPrimary,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  "Ok",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 16.0,
                    color: appTheme.colorPrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Future isNetworkConnected() async {
    if (!await Get.find<NetworkInfo>().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }

  bool _isSuccessCall(dio.Response response) {
    if (response.statusCode != null) {
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    }
    return false;
  }

  Future<List <VisitsResponse>>getVisits(
      {required Map<String, String> headers}) async {
    await isNetworkConnected();

    try {
      headers['apiKey'] = ApiConstants.apiKey;
      var response = await _dio.get(Endpoints.visits,
          options: dio.Options(headers: headers));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');
      if (_isSuccessCall(response)) {
       List<dynamic> data = response.data;
        return data.map((e) => VisitsResponse.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load visits');
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List <ActivityResponse>>getActivities(
      {required Map<String, String> headers}) async {
    await isNetworkConnected();

    try {
      headers['apiKey'] = ApiConstants.apiKey;
      var response = await _dio.get(Endpoints.getActivities,
          options: dio.Options(headers: headers));
      debugPrint('Response ### status: ${response.statusCode}');
      debugPrint('Response ### data: ${response.data}');
      if (_isSuccessCall(response)) {
        List<dynamic> data = response.data;
        return data.map((e) => ActivityResponse.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load activities');
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List <CustomerResponse>>getCustomers(
      {required Map<String, String> headers}) async {
    await isNetworkConnected();

    try {
      headers['apiKey'] = ApiConstants.apiKey;
      var response = await _dio.get(Endpoints.getCustomers,
          options: dio.Options(headers: headers));
      debugPrint('Response &&& status: ${response.statusCode}');
      debugPrint('Response &&& data: ${response.data}');
      if (_isSuccessCall(response)) {
        List<dynamic> data = response.data;
        return data.map((e) => CustomerResponse.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load customers');
      }
    } catch (error, stackTrace) {
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }


  Future<void> createVisit({
    required Map<String, dynamic> requestData,
  }) async {
    await isNetworkConnected();

    try {
      final headers = {
        'apiKey': ApiConstants.apiKey,
      };

      final response = await _dio.post(
        Endpoints.visits,
        data: requestData,
        options: dio.Options(headers: headers),
      );

      debugPrint('Response (POST) status: ${response.statusCode}');
      debugPrint('Response (POST) data: ${response.data}');

      if (!_isSuccessCall(response)) {
        throw Exception('Failed to create visit');
      }
    } catch (error, stackTrace) {
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }


}
