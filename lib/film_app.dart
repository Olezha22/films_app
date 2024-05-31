import 'package:films_app/features/films/bloc/film_info_bloc.dart';
import 'package:films_app/features/home/bloc/bottom_nav_cubit.dart';
import 'package:films_app/themes/film_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/home.dart';

class FilmApp extends StatelessWidget {
  const FilmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmInfoBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: filmAppTheme,
        home: BlocProvider(
          create: (context) => BottomNavCubit(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
