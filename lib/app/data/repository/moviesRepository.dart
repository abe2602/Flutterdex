import 'package:state_navigation/app/data/remote/movieDetailRDS.dart';
import 'package:state_navigation/domain/data/MovieRepositoryDataSource.dart';

import '../../data/remote/movieRDS.dart';

class MoviesRepository extends MovieRepositoryDataSource{

  MoviesRDS movieListProvider = MoviesRDS();
  MovieDetailRDS movieDetailProvider = MovieDetailRDS();

  MoviesRepository(this.movieDetailProvider, this.movieListProvider);

  getMoviesList() => movieListProvider.getMovies();
  getMovieDetail(int id) => movieDetailProvider.getMovieDetail(id);
}
