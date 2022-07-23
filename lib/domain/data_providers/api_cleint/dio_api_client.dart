import "package:dio/dio.dart";

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

  @override
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        uri,
        queryParameters: queryParameters,
      );
      return response.data;
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
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
