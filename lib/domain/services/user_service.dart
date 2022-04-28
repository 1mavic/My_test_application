import "package:flutter_test_application/domain/data_providers/api_client.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";

class UserService {
  final ApiClient _apiClient = ApiClient();

  Future<List<User>> getUsers() async {
    final List<User>? users = await _apiClient.fetchUsers();
    return users ?? <User>[];
  }
}
