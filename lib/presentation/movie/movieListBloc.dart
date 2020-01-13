import 'package:bloc_pattern/bloc_pattern.dart';
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
class MovieListBloc extends BlocBase{
  List<MovieRM> _moviesVM = [];
  MoviesProvider provider = MoviesProvider();
  final _moviesFetcher = PublishSubject<List<Movie>>();
  Stream<List<Movie>> get allMovies => _moviesFetcher.stream;

  
  void getMovieList() async{
    _moviesVM = await provider.getMovies();
    _moviesFetcher.sink.add((_moviesVM.map((movie) => movie.toVM())).toList());
  }

  @override
  void dispose() {
    _moviesFetcher.close();
    super.dispose();
  }
}