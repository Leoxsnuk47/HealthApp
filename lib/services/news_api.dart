import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class NewsApi {
  List<NewsModel> dataStore = [];

  Future<void> getNews() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3ac32f006d3c40f580af8080353fb28a");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['content'] != null &&
            element['content'] != '' &&
            element['author'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            content: element['content'],
            author: element['author'],
          );
          dataStore.add(newsModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<NewsModel> dataStore = [];

  Future<void> getNews(String category) async {
    Uri url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=3ac32f006d3c40f580af8080353fb28a');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['content'] != null &&
            element['content'] != '' &&
            element['author'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            content: element['content'],
            author: element['author'],
          );
          dataStore.add(newsModel);
        }
      });
    }
  }
}
