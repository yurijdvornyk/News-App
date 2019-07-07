import 'package:global_news_app/entity/article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final _databaseName = "articles_database.db";
  static final _databaseVersion = 1;
  static final _tableName = 'articles';
  static final _createTableScript = '''
      CREATE TABLE articles(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        source TEXT, 
        author TEXT, 
        title TEXT,
        description TEXT, 
        url TEXT, 
        urlToImage TEXT, 
        publishedAt TEXT, 
        content TEXT,
        isSaved INTEGER)
  ''';

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(_createTableScript);
      },
      version: _databaseVersion,
    );
  }

  Future<void> saveArticle(Article article) async {
    var db = await databaseProvider.database;
    var exists = await isArticleCached(article);
    if (!exists) {
      await db.insert(_tableName, article.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> saveArticles(List<Article> articles) async {
    await for (var article in Stream.fromIterable(articles)) {
      saveArticle(article);
    }
  }

  Future<bool> isArticleCached(Article article) async {
    var articles = await getArticles();
    for (var dbArticle in articles) {
      if (Article.areSameArticles(dbArticle, article)) {
        return true;
      }
    }
    return false;
  }

  Future<Article> updateArticle(Article article) async {
    var db = await databaseProvider.database;
    await db.update(_tableName, article.toJson(),
        where: "id = ?",
        whereArgs: [article.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return article;
  }

  Future<List<Article>> getArticles() async {
    var db = await databaseProvider.database;
    return db
        .query(_tableName)
        .then((articlesRaw) => articlesRaw.map((v) => Article.fromJson(v)))
        .then((artilesIterable) => Future.value(artilesIterable.toList()))
        .then((articles) {
      articles
          .sort((article1, article2) => article1.comparePublishTime(article2));
      return articles;
    });
  }

  Future<void> deleteArticle(int id) async {
    var db = await databaseProvider.database;
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> clearArticles() async {
    return await getArticles().then(
        (articles) => articles.forEach((article) => deleteArticle(article.id)));
  }
}

final databaseProvider = DatabaseProvider();