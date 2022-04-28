import "dart:convert";
import "dart:developer";

import "package:dio/dio.dart";
import "package:flutter_test_application/config/environment.dart";
import 'package:flutter_test_application/domain/entity/comment/comment_model.dart';
import 'package:flutter_test_application/domain/entity/post/post_model.dart';
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

  Future<List<Post>?> fetchPosts(int userId) async {
    try {
      final Response response =
          await _dio.get("$_baseUrl/posts?userId=$userId");
      final List<Post>? posts = (response.data as List)
          .map((dynamic posts) => Post.fromJson(posts as Map<String, dynamic>))
          .toList();
      return posts;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Comment>?> fetchCommentsToPost(int postId) async {
    try {
      final Response response =
          await _dio.get("$_baseUrl/comments?postId=$postId");
      final List<Comment>? comments = (response.data as List)
          .map((dynamic comment) =>
              Comment.fromJson(comment as Map<String, dynamic>))
          .toList();
      return comments;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> sendComment(Comment newComment) async {
    try {
      final Response response = await _dio
          .post("$_baseUrl/comments", queryParameters: <String, dynamic>{
        "postId": newComment.postId,
        "name": newComment.name,
        "email": newComment.email,
        "body": newComment.body
      });
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
