import 'package:films_app/features/home/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppBarItem extends StatelessWidget {
  final ImageProvider defaultIcon;
  final ImageProvider filledIcon;
  final int page;
  final PageController pageController;

  const BottomAppBarItem({
    super.key,
    required this.defaultIcon,
    required this.page,
    required this.filledIcon,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);

        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 13),
            BlocBuilder<BottomNavCubit, int>(
              builder: (context, state) {
                return Image(
                  image: state == page ? filledIcon : defaultIcon,
                  width: 24,
                  height: 24,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
