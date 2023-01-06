import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocks/bloc/news_bloc.dart';

import 'presentation/ArticleListItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    scheduleMicrotask(() {
      context.read<NewsBloc>().add(LoadNews());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade300,
                    ),
                    onPressed: (() {
                      context.read<NewsBloc>().add(ClearData());
                    }),
                    child: const Text(
                      'Clear',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade300),
                    onPressed: (() {
                      context.read<NewsBloc>().add(RefreshData());
                    }),
                    child: const Text(
                      'Refresh',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Builder(builder: (context) {
        switch (newsBloc.state.status) {
          case NewsStetStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case NewsStetStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case NewsStetStatus.loadSuccess:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: StreamBuilder(
                  stream: newsBloc.getNews,
                  builder: (context, snapshot) {
                    final list = snapshot.data ?? [];
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: ((context, index) {
                          final item = list[index];
                          return ArticleListItem(item);
                        }));
                  },
                ))
              ],
            );
          case NewsStetStatus.loadFailure:
            return Center(
              child: Text(newsBloc.state.error.toString()),
            );
          case NewsStetStatus.cleared:
            return const Center(
              child: Text('No articles'),
            );
          case NewsStetStatus.noInternet:
            if (newsBloc.state.articles.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          itemCount: newsBloc.state.articles.length,
                          itemBuilder: ((context, index) {
                            final item = newsBloc.state.articles[index];
                            return ArticleListItem(item);
                          })))
                ],
              );
            } else {
              return const Center(
                child: Text(
                    'No Internet connection detected, plese try again later!'),
              );
            }
        }
      }),
    );
  }
}
