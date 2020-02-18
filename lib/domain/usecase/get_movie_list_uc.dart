import 'package:state_navigation/domain/data/movie_repository_data_source.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/usecase/base_use_case.dart';

class GetMovieListUC implements BaseUseCase<List<Movie>, GetMovieListParams> {
  GetMovieListUC(this.moviesRepository);

  final MovieRepositoryDataSource moviesRepository;

  @override
  Future<List<Movie>> call(GetMovieListParams params) =>
      moviesRepository.getMoviesList();
}

class GetMovieListParams {}
