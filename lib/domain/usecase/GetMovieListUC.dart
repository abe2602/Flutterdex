import 'package:state_navigation/domain/data/MovieRepositoryDataSource.dart';
import 'package:state_navigation/domain/usecase/baseUseCase.dart';

class GetMovieListUC extends BaseUseCase{

  final MovieRepositoryDataSource moviesRepository;

  GetMovieListUC(this.moviesRepository);

  @override
  Future call(params) async => moviesRepository.getMoviesList();

}

class Params {}