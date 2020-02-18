import 'package:state_navigation/domain/data/movie_repository_data_source.dart';

import 'base_use_case.dart';

class FavoriteMovieUC implements BaseUseCase<void, FavoriteMovieParams> {
  FavoriteMovieUC(this.movieRepository);

  final MovieRepositoryDataSource movieRepository;

  @override
  Future<void> call(FavoriteMovieParams params) =>
      movieRepository.favoriteMovie(params.id);
}

class FavoriteMovieParams {
  FavoriteMovieParams({this.id});

  final int id;
}
