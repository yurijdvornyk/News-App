import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_news_app/entity/article.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage({Key key, @required this.article}) : super(key: key);

  Widget getTopImageContent(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height * 0.4;
    return Stack(children: [
      Container(
        height: imageHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/article_placeholder.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
      FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: article.urlToImage,
          fit: BoxFit.cover,
          height: imageHeight),
      Positioned(
        left: 16,
        top: 28,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      )
    ]);
  }

  Widget getTopContent(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.all(16),
          child: Text(article.title, style: TextStyle(fontSize: 16))),
      ButtonTheme.bar(
        child: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.share),
              onPressed: () => Share.share(article.url),
            ),
            FlatButton(
              child: Icon(Icons.open_in_new),
              onPressed: () => _launchUrl(context, article.url),
            ),
          ],
        ),
      )
    ]);
  }

  Widget getBottomContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Text(article.content),
          InkWell(
              child: Text("[Read more]",
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.end),
              onTap: () => launch(article.url))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      getTopImageContent(context),
      getTopContent(context),
      Divider(),
      getBottomContent(context),
      getBottomContent(context),
      getBottomContent(context),
    ])));
  }

  void _launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Sorry, cannot open website URL"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }
}
