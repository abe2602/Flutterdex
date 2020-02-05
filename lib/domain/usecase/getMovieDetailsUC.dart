import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';
import 'package:state_navigation/domain/usecase/baseUseCase.dart';

class GetMovieDetailsUC implements BaseUseCase<MovieDetail, Params>{
  final MovieRepositoryDataSource movieRepository;

  GetMovieDetailsUC(this.movieRepository);

  @override
  Future<MovieDetail> call(Params params) => movieRepository.getMovieDetail(params.id);

}

class Params {
  final int id;

  Params({this.id});
}
