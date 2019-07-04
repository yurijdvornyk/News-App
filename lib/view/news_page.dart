import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:global_news_app/data/api_helper.dart';
import 'package:global_news_app/data/database_helper.dart';
import 'package:global_news_app/entity/article.dart';
import 'package:http/http.dart' as http;
import 'progress_view.dart';
import 'article_page.dart';

class NewsPage extends StatefulWidget {
  final bool showOnlySaved;
  final bool showSearch;

  NewsPage({Key key, this.showOnlySaved = false, this.showSearch = false})
      : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> _articles;
  List<Object> _content;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  void _showArticle(article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArticlePage(article: article)),
    );
  }

  void _toggleSaveState(article) {
    DatabaseHelper.instance
        .toggleSave(article)
        .then((_) => DatabaseHelper.instance.getArticles())
        .then((articles) {
      setState(() {
        _setContent(articles);
      });
    });
  }

  void _setContent(List<Article> articles) {
    _articles = articles;
    _content = [];
    for (var i = 0; i < _articles.length; i++) {
      if (i == 0 || _articles[i].date != _articles[i - 1].date) {
        _content.add(articles[i].date);
      }
      _content.add(articles[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_content == null || _content.isEmpty) {
      body = progressIndicator;
    } else {
      body = RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () => Future<Null>(loadNews),
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(height: 0),
            itemCount: _content == null ? 0 : _content.length,
            itemBuilder: (BuildContext context, int index) {
              return _createArticleTile(_content[index]);
            },
          ));
    }
    return Scaffold(body: body);
  }

  Widget _createArticleTile(Object object) {
    if (object is Article) {
      var article = object;
      var firstRow =
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(article.time, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(article.source)
      ]);

      firstRow.children.add(GestureDetector(
          child: article.isSaved
              ? Icon(Icons.bookmark)
              : Icon(Icons.bookmark_border),
          onTap: () => _toggleSaveState(article)));

      var secondRow =
          Text(article.title, maxLines: 1, overflow: TextOverflow.ellipsis);

      return ListTile(
        title: firstRow,
        subtitle: secondRow,
        onTap: () => _showArticle(article),
      );
    } else if (object is String) {
      return ListTile(
          title: Text(
        object,
        textAlign: TextAlign.center,
      ));
    }
  }

  Future<Null> loadNews() async {
    List<Article> articles;
    if (widget.showOnlySaved) {
      articles = await DatabaseHelper.instance.getArticles().then(
          (articles) => articles.where((article) => article.isSaved).toList());
    } else {
      articles = await ApiHelper.instance
          .loadArticles()
          .then((articles) => DatabaseHelper.instance.saveArticles(articles))
          .then((_) => DatabaseHelper.instance.getArticles());
    }
    setState(() {
      _setContent(articles);
    });
  }
}
