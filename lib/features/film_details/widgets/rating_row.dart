

import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  final double rate;

  const RatingRow({
    super.key,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          Text(
            "$rate  ",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          for (int i = 0; i < rate.floor(); i++)
            const Row(
              children: [
                Image(image: AssetImage("assets/star.png")),
                SizedBox(width: 4),
              ],
            ),
          if (rate % 1 != 0)
            const Row(
              children: [
                Image(image: AssetImage("assets/half_star.png")),
                SizedBox(width: 4),
              ],
            ),
          for (int i = 0; i < 5 - rate.ceil(); i++)
            const Image(image: AssetImage("assets/empty_star.png")),
        ],
      ),
    );
  }
}
