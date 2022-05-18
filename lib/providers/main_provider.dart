import 'dart:convert';
import 'package:corebornassessmenttask/models/album_model.dart';
import 'package:corebornassessmenttask/models/comment_model.dart';
import 'package:corebornassessmenttask/models/post_model.dart';
import 'package:corebornassessmenttask/models/user_model.dart';
import 'package:corebornassessmenttask/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MainProvider with ChangeNotifier {
  List<PostModel> posts = [];
  List<CommentModel> postComments = [];
  List<AlbumModel> allAlbums = [];
  List<UserModel> users = [];

  Future<String> getPosts() async {
    try {
      Response response = await ApiService.getPosts();
      posts = [];
      var json = jsonDecode(response.body);
      for (var element in json) {
        PostModel post = PostModel.fromJson(element);
        posts.add(post);
      }
      notifyListeners();
      return '0';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getCommentsForPost(int postId) async {
    try {
      Response response = await ApiService.getComments(postId);
      postComments = [];
      var json = jsonDecode(response.body);
      for (var element in json) {
        CommentModel comment = CommentModel.fromJson(element);
        postComments.add(comment);
      }
      notifyListeners();
      return '0';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getAlbums() async {
    try {
      Response response = await ApiService.getAlbums();
      allAlbums = [];
      var json = jsonDecode(response.body);
      for (var element in json) {
        AlbumModel albumModel = AlbumModel.fromJson(element);
        allAlbums.add(albumModel);
      }
      notifyListeners();
      return '0';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getUsers() async {
    try {
      Response response = await ApiService.getUsers();
      users = [];
      var json = jsonDecode(response.body);
      for (var element in json) {
        if (posts.isEmpty) {
          String response = await getPosts();
          if (response != '0') {
            return response;
          }
        }
        if (allAlbums.isEmpty) {
          String response = await getAlbums();
          if (response != '0') {
            return response;
          }
        }
        int postCount = 0;
        for (var post in posts) {
          if (post.userId == element['id']) {
            postCount++;
          }
        }
        int albumCount = 0;
        for (var album in allAlbums) {
          if (album.userId == element['id']) {
            albumCount++;
          }
        }
        UserModel user = UserModel.fromJson(element, albumCount, postCount);
        users.add(user);
      }
      notifyListeners();
      return '0';
    } catch (e) {
      return e.toString();
    }
  }
}
