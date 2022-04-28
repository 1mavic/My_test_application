import "dart:convert";

import "package:flutter_test_application/domain/data_providers/api_client.dart";
import "package:flutter_test_application/domain/data_providers/local_data_provider.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";

class UserService {
  final ApiClient _apiClient = ApiClient();
  final LocalDataProvider _localDataProvider = LocalDataProvider();

  List<User> makeUsers(String newUsers) {
    try {
      final dynamic _users = jsonDecode(newUsers);
      final List<User> users = (_users as List)
          .map((dynamic user) => User.fromJson(user as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      return <User>[];
    }
  }

  Future<List<User>> getUsers() async {
    final String? localUsers = _localDataProvider.checkUser();

    if (localUsers != null) {
      return makeUsers(localUsers);
    }

    final List<User>? users = await _apiClient.fetchUsers();
    if (users == null) {
      return <User>[];
    }
    final String userString =
        jsonEncode(users.map((User user) => user.toJson()).toList());
    _localDataProvider.saveUsers(userString);
    return users;
  }
}
