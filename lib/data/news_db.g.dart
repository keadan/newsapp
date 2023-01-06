// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_db.dart';

// ignore_for_file: type=lint
class $LocalArticlesTable extends LocalArticles
    with TableInfo<$LocalArticlesTable, LocalArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [title, author, description, imageUrl];
  @override
  String get aliasedName => _alias ?? 'local_articles';
  @override
  String get actualTableName => 'local_articles';
  @override
  VerificationContext validateIntegrity(Insertable<LocalArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LocalArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalArticle(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
    );
  }

  @override
  $LocalArticlesTable createAlias(String alias) {
    return $LocalArticlesTable(attachedDatabase, alias);
  }
}

class LocalArticle extends DataClass implements Insertable<LocalArticle> {
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  const LocalArticle(
      {required this.title,
      required this.author,
      required this.description,
      required this.imageUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  LocalArticlesCompanion toCompanion(bool nullToAbsent) {
    return LocalArticlesCompanion(
      title: Value(title),
      author: Value(author),
      description: Value(description),
      imageUrl: Value(imageUrl),
    );
  }

  factory LocalArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalArticle(
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  LocalArticle copyWith(
          {String? title,
          String? author,
          String? description,
          String? imageUrl}) =>
      LocalArticle(
        title: title ?? this.title,
        author: author ?? this.author,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
      );
  @override
  String toString() {
    return (StringBuffer('LocalArticle(')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, author, description, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalArticle &&
          other.title == this.title &&
          other.author == this.author &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl);
}

class LocalArticlesCompanion extends UpdateCompanion<LocalArticle> {
  final Value<String> title;
  final Value<String> author;
  final Value<String> description;
  final Value<String> imageUrl;
  const LocalArticlesCompanion({
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  LocalArticlesCompanion.insert({
    required String title,
    required String author,
    required String description,
    required String imageUrl,
  })  : title = Value(title),
        author = Value(author),
        description = Value(description),
        imageUrl = Value(imageUrl);
  static Insertable<LocalArticle> custom({
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  LocalArticlesCompanion copyWith(
      {Value<String>? title,
      Value<String>? author,
      Value<String>? description,
      Value<String>? imageUrl}) {
    return LocalArticlesCompanion(
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalArticlesCompanion(')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

abstract class _$NewsDatabase extends GeneratedDatabase {
  _$NewsDatabase(QueryExecutor e) : super(e);
  late final $LocalArticlesTable localArticles = $LocalArticlesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [localArticles];
}
