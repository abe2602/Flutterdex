import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/model/movie.dart';

import 'baseUseCase.dart';

class FavoriteMovieUC implements BaseUseCase<List<Movie>, Params2> {
  final MovieRepositoryDataSource movieRepository;

  FavoriteMovieUC(this.movieRepository);

  @override
  Future<List<Movie>> call(Params2 params) =>
      movieRepository.favoriteMovie(params.id);
}

class Params2 {
  final int id;

  Params2({this.id});
}
