import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';

abstract class MovieRepositoryDataSource {
  Future<MovieDetail> getMovieDetail(int id);
  Future<List<Movie>> getMoviesList();
  Future<List<Movie>> favoriteMovie(int id);
}