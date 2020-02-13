import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';
import 'package:state_navigation/domain/usecase/baseUseCase.dart';

class GetMovieDetailsUC implements BaseUseCase<MovieDetail, GetMovieDetailsParams> {
  final MovieRepositoryDataSource movieRepository;

  GetMovieDetailsUC(this.movieRepository);

  @override
  Future<MovieDetail> call(GetMovieDetailsParams params) =>
      movieRepository.getMovieDetail(params.id);
}

class GetMovieDetailsParams {
  final int id;

  GetMovieDetailsParams({this.id});
}
