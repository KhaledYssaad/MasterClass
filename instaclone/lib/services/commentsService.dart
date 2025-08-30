import 'dart:convert';
import 'package:firstapp/models/commentModel.dart';
import 'package:flutter/services.dart' show rootBundle;

class ApiService {
  static Future<List<CommentModel>> fetchComments() async {
    final String response = await rootBundle.loadString(
      'assets/commentsData.json',
    );
    final List<dynamic> data = json.decode(response);
    return data
        .map(
          (json) => CommentModel(
            username: json['username'],
            profileImage: json['profileImage'],
            text: json['text'],
            time: json['time'],
          ),
        )
        .toList();
  }
}
