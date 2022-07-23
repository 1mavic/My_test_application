import "package:hive_flutter/hive_flutter.dart";

abstract class LocalDataProvider {
  void clearAll();
  String? checkUser();
  void saveUsers(String users);
  String? checkPosts(int userId);
  void savePosts(String users, int userId);
  String? checkAlbums(int userId);
  void saveAlbums(String albums, int userId);
  String? checkComments(int postId);
  void saveComments(String albums, int postId);
}

class HiveDataProvider implements LocalDataProvider {
  @override
  void clearAll() {
    Hive.box<String>("users").clear();
    Hive.box<String>("posts").clear();
    Hive.box<String>("albums").clear();
    Hive.box<String>("comments").clear();
  }

  @override
  String? checkUser() {
    final String? users = Hive.box<String>("users").get("data");
    return users;
  }

  @override
  void saveUsers(String users) {
    final Box<String> _userBox = Hive.box("users");
    _userBox.put("data", users);
  }

  @override
  String? checkPosts(int userId) {
    final String? posts = Hive.box<String>("posts").get("$userId");
    return posts;
  }

  @override
  void savePosts(String users, int userId) {
    final Box<String> _userBox = Hive.box("posts");
    _userBox.put("$userId", users);
  }

  @override
  String? checkAlbums(int userId) {
    final String? posts = Hive.box<String>("albums").get("$userId");
    return posts;
  }

  @override
  void saveAlbums(String albums, int userId) {
    final Box<String> _userBox = Hive.box("albums");
    _userBox.put("$userId", albums);
  }

  @override
  String? checkComments(int postId) {
    final String? posts = Hive.box<String>("comments").get("$postId");
    return posts;
  }

  @override
  void saveComments(String albums, int postId) {
    final Box<String> _userBox = Hive.box("comments");
    _userBox.put("$postId", albums);
  }
}
