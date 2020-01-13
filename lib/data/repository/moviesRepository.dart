import '../../data/remote/movieRDS.dart';

class MoviesRepository{
  MoviesRDS provider = MoviesRDS();

  getMovies() => provider.getMovies();

}
