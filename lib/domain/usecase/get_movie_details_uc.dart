import 'package:state_navigation/domain/data/movie_repository_data_source.dart';
import 'package:state_navigation/domain/model/movie_detail.dart';
import 'package:state_navigation/domain/usecase/base_use_case.dart';

class GetMovieDetailsUC
    implements BaseUseCase<MovieDetail, GetMovieDetailsParams> {
  GetMovieDetailsUC(this.movieRepository);

  final MovieRepositoryDataSource movieRepository;

  @override
  Future<MovieDetail> call(GetMovieDetailsParams params) =>
      movieRepository.getMovieDetail(params.id);
}

class GetMovieDetailsParams {
  GetMovieDetailsParams({this.id});

  final int id;
}
