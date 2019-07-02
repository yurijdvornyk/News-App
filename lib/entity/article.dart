import 'source.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Article {
  int id;
  String source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  bool isSaved;

  DateTime get publishTime {
    return publishedAt != null ? DateTime.parse(publishedAt) : null;
  }

  String get time {
    return DateFormat('HH:mm').format(publishTime);
  }

  String get date {
    return DateFormat('MM.dd').format(publishTime);
  }

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.isSaved});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['source'] != null) {
      if (json['source'] is Map) {
        source = Source.fromJson(json['source']).name;
      } else {
        source = json['source'];
      }
    } else {
      source = null;
    }
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
    isSaved = json['isSaved'] == null ? false : json['isSaved'] == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['source'] = source;
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    data['isSaved'] = isSaved ? 1 : 0;
    return data;
  }

  bool isSame(Article other) {
    return areSameArticles(this, other);
  }

  int comparePublishTime(Article other) {
    // We need to multiply DateTyme comparison by -1 because we need later news at the beginning.
    return -publishTime.compareTo(other.publishTime);
  }

  static bool areSameArticles(Article first, Article second) {
    return first.title == second.title &&
        first.source == second.source &&
        first.publishedAt == second.publishedAt;
  }
}
