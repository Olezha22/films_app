import 'package:films_app/features/favorite/favorite.dart';
import 'package:films_app/features/home/bloc/bottom_nav_cubit.dart';
import 'package:films_app/features/home/widgets/widgets.dart';
import 'package:films_app/features/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../films/films.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> pages =  [
    const FilmsScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
  ];

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int page) => onPageChanged(page),
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomAppBarWidget(pageController: pageController),
    );
  }
}
