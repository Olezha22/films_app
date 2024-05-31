

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          Text(text),
          const Text(
            ".",
            style: TextStyle(color: Color(0xFFFFC700)),
          ),
        ],
      ),
    );
  }
}
