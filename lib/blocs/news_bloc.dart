import 'dart:async';

import 'package:global_news_app/blocs/base_bloc.dart';
import 'package:global_news_app/entity/article.dart';
import 'package:global_news_app/resources/database_provider.dart';
import 'package:global_news_app/resources/news_repository.dart';

class NewsBloc implements BaseBloc {
  final _repository = NewsRepository();
  final _newsFetcher = StreamController<List<Article>>();

  Stream<List<Article>> get articlesStream => _newsFetcher.stream;

  loadNews({onlySaved = false}) async {
    var articles = onlySaved
        ? await _repository.loadSavedArticles()
        : await _repository
            .loadArticles()
            .then((articles) => databaseProvider.saveArticles(articles))
            .then((_) => databaseProvider.getArticles());
    _newsFetcher.sink.add(articles);
  }

  @override
  void dispose() {
    _newsFetcher.close();
  }
}
