import 'package:films_app/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchErrorMessage extends StatelessWidget {
  const SearchErrorMessage({super.key});

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
              BlocProvider.of<SearchBloc>(context).add(SearchFilmEvent(''));
            },
            child: const Text("REFRESH",
                style: TextStyle(color: Color(0xFFFFC700))),
          ),
        ],
      ),
    );
  }
}
