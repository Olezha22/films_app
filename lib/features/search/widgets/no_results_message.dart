import 'package:flutter/material.dart';

class NoResultsMessage extends StatelessWidget {
  const NoResultsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No results found"),
          Text(
            "Type something else",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
