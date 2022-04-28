import "package:hive_flutter/hive_flutter.dart";

class LocalDataProvider {
  // final Box<String> _userBox = Hive.box("users");
  String? checkUser() {
    final String? users = Hive.box<String>("users").get("data");
    return users;
  }

  void saveUsers(String users) {
    final Box<String> _userBox = Hive.box("users");
    _userBox.put("data", users);
  }

  String? checkPosts(int userId) {
    final String? posts = Hive.box<String>("posts").get("$userId");
    return posts;
  }

  void savePosts(String users, int userId) {
    final Box<String> _userBox = Hive.box("posts");
    _userBox.put("$userId", users);
  }

  String? checkAlbums(int userId) {
    final String? posts = Hive.box<String>("albums").get("$userId");
    return posts;
  }

  void saveAlbums(String albums, int userId) {
    final Box<String> _userBox = Hive.box("albums");
    _userBox.put("$userId", albums);
  }

  String? checkComments(int postId) {
    final String? posts = Hive.box<String>("comments").get("$postId");
    return posts;
  }

  void saveComments(String albums, int postId) {
    final Box<String> _userBox = Hive.box("comments");
    _userBox.put("$postId", albums);
  }
}
