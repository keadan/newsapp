import 'dart:io';

import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'news_db.g.dart';

class LocalArticles extends Table {
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
}

@DriftDatabase(tables: [LocalArticles])
class NewsDatabase extends _$NewsDatabase {
  NewsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<LocalArticle>> getArticles() async {
    return select(localArticles).get();
  }

  Future<int> addArticle(LocalArticle article) async {
    return into(localArticles).insert(article);
  }

  Future<void> clearDatabase() async {
    await delete(localArticles).go();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
