import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_news_app/blocs/article_bloc.dart';
import 'package:global_news_app/blocs/news_bloc.dart';
import 'package:global_news_app/entity/article.dart';
import 'article_page.dart';

class NewsPage extends StatefulWidget {
  final bool showOnlySaved;
  final bool showSearch;

  NewsPage({Key key, this.showOnlySaved = false, this.showSearch = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  final _newsBloc = NewsBloc();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            initialData: null,
            stream: _newsBloc.articlesStream,
            builder: (context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () => reload(),
                    child: snapshot.data.length == 0
                        ? Center(child: Text("No content"))
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                Divider(height: 0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _createArticleTile(
                                  context, snapshot.data[index]);
                            },
                          ));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  reload() => _newsBloc.loadNews(onlySaved: widget.showOnlySaved);

  Widget _createArticleTile(context, item) {
    if (item is Article) {
      var firstRow =
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(item.time, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(item.source)
      ]);

      firstRow.children.add(GestureDetector(
          child:
              item.isSaved ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
          onTap: () => articleBloc.toggleSaveState(item)));

      var secondRow =
          Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis);

      return ListTile(
        title: firstRow,
        subtitle: secondRow,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticlePage(article: item)),
          );
        },
      );
    } else if (item is String) {
      return ListTile(title: Text(item, textAlign: TextAlign.center));
    }
  }

  @override
  void dispose() {
    _newsBloc.dispose();
    super.dispose();
  }
}
