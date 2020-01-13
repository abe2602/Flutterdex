import '../../data/remote/movieRDS.dart';

class MoviesRepository{
  MoviesProvider provider = MoviesProvider();

  getMovies() => provider.getMovies();
}
