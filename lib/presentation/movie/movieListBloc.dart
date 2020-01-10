import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/movieRDS.dart';
import '../../data/movieRM.dart';
import '../../data/mapper.dart';
import 'movie.dart';

/*
* Colocar uma stream com a listagem!
* É como um Observable que pega do data e, quando a view pede, envia a listagem
* */
class MovieListBloc {
  List<Movie> moviesVM = [];
  void getMovieList() async {
    final Stream<MovieRM> movies = await getMovies();
    movies.listen( (MovieRM movie){
      moviesVM.add(movie.toVM());
    });

    print(moviesVM);
  }
}