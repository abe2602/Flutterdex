import 'package:state_navigation/domain/data/movie_repository_data_source.dart';
import 'package:state_navigation/domain/model/favorite.dart';
import 'package:state_navigation/domain/usecase/base_use_case.dart';

class GetFavoriteListUC
    implements BaseUseCase<List<Favorite>, GetFavoriteListParams> {
  GetFavoriteListUC(this.moviesRepository);

  final MovieRepositoryDataSource moviesRepository;

  @override
  Future<List<Favorite>> call(GetFavoriteListParams params) =>
      moviesRepository.getFavoriteList();
}

class GetFavoriteListParams {}
