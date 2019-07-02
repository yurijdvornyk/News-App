import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_news_app/entity/article.dart';

class ArticlePage extends StatefulWidget {

  final Article article;

  ArticlePage({Key key, @required this.article}): super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('aaa');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.title, 
          maxLines: 1, 
          overflow: TextOverflow.ellipsis
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _createHeaderWidget(),
          _createContentWidget(),
        ]
      ),
    );
  }

  Widget _createHeaderWidget() {
    if (widget.article.urlToImage != null) {
      return Image.network(widget.article.urlToImage);
    } else {
      return Icon(Icons.place);
    }
  }

  Widget _createContentWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.article.title == null ? "" : widget.article.title),
        Text(widget.article.description == null ? "" : widget.article.description),
        Text(widget.article.content == null ? "" : widget.article.content),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.article.author == null ? "" : widget.article.author,
              style: TextStyle(fontStyle: FontStyle.italic),
            )
          ],
        ),
      ]);
  }

  // void _launchURL(String url) async {
  //   const url = 'https://flutter.io';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}