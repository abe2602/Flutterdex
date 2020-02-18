import 'package:state_navigation/domain/model/favorite.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movie_detail.dart';

abstract class MovieRepositoryDataSource {
  Future<MovieDetail> getMovieDetail(int id);
  Future<List<Movie>> getMoviesList();
  Future<List<Favorite>> getFavoriteList();
  Future<void> favoriteMovie(int id);
}