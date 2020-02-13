import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/usecase/baseUseCase.dart';

class GetMovieListUC implements BaseUseCase<List<Movie>, GetMovieListParams> {
  final MovieRepositoryDataSource moviesRepository;

  GetMovieListUC(this.moviesRepository);

  @override
  Future<List<Movie>> call(GetMovieListParams params) => moviesRepository.getMoviesList();
}

class GetMovieListParams {}
