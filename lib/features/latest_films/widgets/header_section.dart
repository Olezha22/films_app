import 'package:films_app/features/latest_films/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final VoidCallback onBackTap;

  const HeaderSection({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBackTap,
          child: const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: SizedBox(
              height: 25,
              width: 25,
              child: Image(image: AssetImage("assets/back.png")),
            ),
          ),
        ),
        const TextWidget(text: "Latest"),
      ],
    );
  }
}



