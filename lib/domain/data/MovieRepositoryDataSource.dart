import 'package:state_navigation/app/presentation/movie/movie.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';

abstract class MovieRepositoryDataSource {
  Future<MovieDetail> getMovieDetail(int id);
  Future<List<Movie>> getMoviesList();
}