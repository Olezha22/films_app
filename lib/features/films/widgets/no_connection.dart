import 'package:films_app/features/films/bloc/film_info_bloc.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({
    super.key,
    required FilmInfoBloc filmInfoBloc,
  }) : _filmInfoBloc = filmInfoBloc;

  final FilmInfoBloc _filmInfoBloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("ERROR"),
          const Text(
            "Check your internet connection",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: () {
                _filmInfoBloc.add(LoadFilmInfo());
              },
              child: const Text("REFRESH",
                  style: TextStyle(color: Color(0xFFFFC700)))),
        ],
      ),
    );
  }
}
