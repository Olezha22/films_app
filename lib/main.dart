import 'package:dio/dio.dart';
import 'package:films_app/film_app.dart';
import 'package:films_app/repositories/film/film_repository.dart';
import 'package:films_app/repositories/hive/hive_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'repositories/search_film/search_repository.dart';

void main() async {
  GetIt.I.registerSingleton(FilmRepository(dio: Dio()));
  GetIt.I.registerSingleton(SearchRepository(dio: Dio()));
  WidgetsFlutterBinding.ensureInitialized();
  HiveRepository.initHive();
  runApp(const FilmApp());
}
