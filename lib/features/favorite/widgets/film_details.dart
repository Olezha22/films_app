import 'package:flutter/material.dart';

class FilmDetails extends StatelessWidget {
  final String title;
  final double rate;
  final String genres;
  final String description;

  const FilmDetails({
    super.key,
    required this.title,
    required this.rate,
    required this.genres,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              "$rate  ",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ...List.generate(rate.floor(), (index) {
              return const Row(
                children: [
                  Image(image: AssetImage("assets/star.png")),
                  SizedBox(width: 4),
                ],
              );
            }),
            if (rate % 1 != 0)
              const Row(
                children: [
                  Image(image: AssetImage("assets/half_star.png")),
                  SizedBox(width: 4),
                ],
              ),
            ...List.generate(5 - rate.ceil(), (index) {
              return const Image(image: AssetImage("assets/empty_star.png"));
            }),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          genres,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Color(0xFF888888),
          ),
        ),
      ],
    );
  }
}
