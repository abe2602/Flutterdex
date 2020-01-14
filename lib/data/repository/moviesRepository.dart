import 'package:state_navigation/data/remote/movieDetailRDS.dart';

import '../../data/remote/movieRDS.dart';

class MoviesRepository{
  MoviesRDS movieListProvider = MoviesRDS();
  MovieDetailRDS movieDetailProvider = MovieDetailRDS();

  getMoviesList() => movieListProvider.getMovies();
  getMovieDetail(int id) => movieDetailProvider.getMovieDetail(id);
}
