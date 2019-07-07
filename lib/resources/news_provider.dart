import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:global_news_app/entity/news.dart';

class NewsProvider {
  Future<News> loadNews() async {
    var response = await rootBundle.loadString('assets/dummynews.json'); //await http.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=' + NEWS_API_KEY);
    return News.fromJson(json.decode(response)); // NewsResponse.fromJson(json.decode(response.body));
  }
}
