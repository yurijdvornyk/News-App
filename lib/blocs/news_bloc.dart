import 'dart:async';

import 'package:global_news_app/blocs/base_bloc.dart';
import 'package:global_news_app/entity/article.dart';
import 'package:global_news_app/resources/database_provider.dart';
import 'package:global_news_app/resources/news_repository.dart';

class NewsBloc implements BaseBloc {
  final _repository = NewsRepository();
  final _newsController = StreamController<List<Article>>.broadcast();
  final _articleController = StreamController<Article>.broadcast();

  Stream<List<Article>> get newsStream => _newsController.stream;
  Stream<Article> get articleStream => _articleController.stream;

  void toggleSaveState(Article article) async {
    article.isSaved = !article.isSaved;
    _articleController.sink.add(await databaseProvider.updateArticle(article));
  }

  loadNews({onlySaved = false}) async {
    var articles = onlySaved
        ? await _repository.loadSavedArticles()
        : await _repository
            .loadArticles()
            .then((articles) => databaseProvider.saveArticles(articles))
            .then((_) => databaseProvider.getArticles());
    _newsController.sink.add(articles);
  }

  @override
  void dispose() {
    _newsController.close();
    _articleController.close();
  }
}
