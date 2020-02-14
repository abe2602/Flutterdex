import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/model/favorite.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/usecase/baseUseCase.dart';

class GetFavoriteListUC implements BaseUseCase<List<Favorite>, GetFavoriteListParams> {
  final MovieRepositoryDataSource moviesRepository;

  GetFavoriteListUC(this.moviesRepository);

  @override
  Future<List<Favorite>> call(GetFavoriteListParams params) => moviesRepository.getFavoriteList();
}

class GetFavoriteListParams {}
