import 'package:dartz/dartz.dart';
import 'package:state_navigation/app/data/remote/movieDetailRDS.dart';
import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';

import '../../data/remote/movieRDS.dart';

class MoviesRepository extends MovieRepositoryDataSource{

  MoviesRDS movieListProvider = MoviesRDS();
  MovieDetailRDS movieDetailProvider = MovieDetailRDS();

  MoviesRepository(this.movieDetailProvider, this.movieListProvider);

  Future<List<Movie>> getMoviesList() => movieListProvider.getMovies();
  Future<MovieDetail> getMovieDetail(int id) => movieDetailProvider.getMovieDetail(id);
}
