import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constant/constants.dart';
import 'package:news_app/model/model_news.dart';

class API_MANAGER {
  Future<ModelNews> getNews() async {
    var response = await http.get(Strings.url);
    ModelNews newsModel;
    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        newsModel = ModelNews.fromJson(jsonMap);
      }
      return newsModel;
    } catch (e) {
      return newsModel;
    }
  }
}
