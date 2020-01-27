import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/usecase/baseUseCase.dart';

class GetMovieDetailsUC extends BaseUseCase{
  final MovieRepositoryDataSource movieRepository;

  GetMovieDetailsUC(this.movieRepository);
  
  @override
  Future call(params) async => movieRepository.getMovieDetail(params.id);

}

class Params {
  final int id;

  Params({this.id});
}
