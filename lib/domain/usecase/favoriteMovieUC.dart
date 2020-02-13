import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';

import 'baseUseCase.dart';

class FavoriteMovieUC implements BaseUseCase<void, FavoriteMovieParams> {
  final MovieRepositoryDataSource movieRepository;

  FavoriteMovieUC(this.movieRepository);

  @override
  call(FavoriteMovieParams params) =>
      movieRepository.favoriteMovie(params.id);
}

class FavoriteMovieParams {
  final int id;

  FavoriteMovieParams({this.id});
}
