import 'package:films_app/features/home/widgets/bottom_app_bar_item.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF0B0B0B),
      height: 65,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomAppBarItem(
            defaultIcon: const AssetImage('assets/home.png'),
            page: 0,
            filledIcon: const AssetImage('assets/sel_home.png'),
            pageController: pageController,
          ),
          BottomAppBarItem(
            defaultIcon: const AssetImage('assets/search.png'),
            page: 1,
            filledIcon: const AssetImage('assets/sel_search.png'),
            pageController: pageController,
          ),
          BottomAppBarItem(
            defaultIcon: const AssetImage('assets/favorite.png'),
            page: 2,
            filledIcon: const AssetImage('assets/sel_favorite.png'),
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}
