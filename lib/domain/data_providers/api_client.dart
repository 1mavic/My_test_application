import "dart:convert";
import "dart:developer";

import "package:dio/dio.dart";
import "package:flutter_test_application/config/environment.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";

class ApiClient {
  final Dio _dio = Dio();
  final String _baseUrl = env.apiUrl;

  Future<List<User>?> fetchUsers() async {
    try {
      final Response response = await _dio.get("$_baseUrl/users");
      final List<User>? users = (response.data as List)
          .map((dynamic user) => User.fromJson(user as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
