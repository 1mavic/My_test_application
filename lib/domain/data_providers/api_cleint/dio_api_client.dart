import "dart:developer";
import "dart:io";
import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:my_app/domain/entity/api_errors/api_error.dart";

abstract class ApiClient {
  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  });
}

class DioApi extends ApiClient {
  final Dio _dio = Dio();
  final String baseUrl;
  final List<Interceptor>? interceptors;

  DioApi(this.baseUrl, this.interceptors) {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.addAll(interceptors ?? <Interceptor>[]);
  }

  ApiError _errorMessage(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        return RequestTimeOut();
      case DioErrorType.sendTimeout:
        return SendTimeOut();
      default:
        return UnExpectedException();
    }
  }

  @override
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        baseUrl + uri,
        queryParameters: queryParameters,
      );
      return response.data;
    } on SocketException catch (_) {
      throw NoInternetException();
    } on DioError catch (e) {
      throw _errorMessage(e);
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post(
        baseUrl + uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on SocketException catch (_) {
      throw NoInternetException();
    } on DioError catch (e) {
      throw _errorMessage(e);
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}

class CustomInterceptors extends Interceptor {
  CustomInterceptors();
  // final StreamController<DioError> _errorStreamController;
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      log("RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}");
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    return handler.reject(err);
  }
}
