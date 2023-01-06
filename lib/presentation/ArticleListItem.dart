import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/article.dart';

// ignore: must_be_immutable
class ArticleListItem extends StatelessWidget {
  Article article;
  @override
  ArticleListItem(this.article);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CachedNetworkImage(
                width: 120,
                height: 90,
                imageUrl: article.urlToImage ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  article.title ?? '',
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              article.author ?? '',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Text(
            article.description ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ]),
      ),
    );
  }
}
