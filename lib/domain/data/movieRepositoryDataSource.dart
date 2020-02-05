import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepositoryDataSource {
  Future<MovieDetail> getMovieDetail(int id);
  Future<List<Movie>> getMoviesList();
}