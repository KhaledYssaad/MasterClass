import 'dart:convert';
import 'package:firstapp/models/postModel.dart';
import 'package:flutter/services.dart' show rootBundle;

class ApiService {
  static Future<List<PostModel>> fetchPosts() async {
    final String response = await rootBundle.loadString('assets/postData.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => PostModel.fromJson(json)).toList();
  }
}
