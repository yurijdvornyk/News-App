import 'dart:async';

import 'package:global_news_app/blocs/base_bloc.dart';
import 'package:global_news_app/entity/article.dart';
import 'package:global_news_app/resources/database_provider.dart';

class ArticleBloc implements BaseBloc {

  final _articleController = StreamController<Article>();
  get articleStream => _articleController.stream;

  void toggleSaveState(Article article) async {
    article.isSaved = !article.isSaved;
    _articleController.sink.add(await databaseProvider
        .updateArticle(article));
  }

  @override
  void dispose() {
    _articleController.close();
  }
}

final articleBloc = ArticleBloc();