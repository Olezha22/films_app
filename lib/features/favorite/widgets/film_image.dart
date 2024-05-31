import 'package:flutter/material.dart';

class FilmImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDelete;

  const FilmImage({
    super.key,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            color: Colors.white,
          ),
          width: 182,
          height: 273,
          margin: const EdgeInsets.all(15.0),
        ),
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: GestureDetector(
            onTap: onDelete,
            child: const Image(image: AssetImage("assets/sel_favorite.png")),
          ),
        ),
      ],
    );
  }
}
