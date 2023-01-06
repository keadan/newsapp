part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadNews extends NewsEvent {}

class ClearData extends NewsEvent {}

class RefreshData extends NewsEvent {}
