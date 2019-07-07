import 'package:global_news_app/entity/article.dart';
import 'package:global_news_app/resources/news_provider.dart';

class NewsRepository {
  final _newsProvider = NewsProvider();

  Future<List<Article>> loadArticles() async {
    return await _newsProvider.loadNews().then((news) => news.articles);
  }

  Future<List<Article>> loadSavedArticles() async {
    return loadArticles().then((articles) => articles.where((article) => article.isSaved).toList());
  }
}