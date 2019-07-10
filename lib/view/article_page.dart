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
    return Stack(children: [
      Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(article.urlToImage),
              fit: BoxFit.cover,
            ),
          )),
      Positioned(
        left: 16,
        top: 16,
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
      // Padding(
      //   padding: EdgeInsets.only(left: 16, right: 16),
      //   child: Row(children: [
      //     Text(article.time),
      //     Text(" | "),
      //     Text(article.source),
      //     Text(" | "),
      //     Text(article.author)
      //   ]),
      // ),
      ButtonTheme.bar(
        child: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child:
                  Icon(Icons.share), //Text('SHARE', semanticsLabel: 'Share'),
              onPressed: () => Share.share(article.url),
            ),
            FlatButton(
              child: Icon(Icons
                  .open_in_new), //Text('EXPLORE', semanticsLabel: 'Explore'),
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
          new InkWell(
              child: new Text("[Read more]",
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.end),
              onTap: () => launch(article.url))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      getTopImageContent(context),
      getTopContent(context),
      getBottomContent(context)
    ])));
  }

  // List<Widget> _createContent() {
  //   List<Widget> result = [];
  //   if (article.urlToImage != null) {
  //     result.add(Card(
  //         child: FadeInImage.memoryNetwork(
  //             placeholder: kTransparentImage, image: article.urlToImage)));
  //   }
  //   return result;
  // }

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
