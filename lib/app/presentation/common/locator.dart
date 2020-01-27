import 'package:get_it/get_it.dart';
import 'package:state_navigation/domain/usecase/GetMovieDetailsUC.dart';
import 'package:state_navigation/domain/usecase/GetMovieListUC.dart';
import '../../data/repository/moviesRepository.dart';
import '../../data/remote/movieDetailRDS.dart';
import '../../data/remote/movieRDS.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Repositórios
  locator.registerLazySingleton(() => MoviesRDS());//MoviesRDS movieListProvider = ;
  locator.registerLazySingleton(() => MovieDetailRDS()); //MovieDetailRDS movieDetailProvider = MovieDetailRDS();

  locator.registerLazySingleton(() => MoviesRepository(locator<MovieDetailRDS>(), locator<MoviesRDS>()));

  //Use Cases
  locator.registerFactory(() => GetMovieDetailsUC(locator<MoviesRepository>()));
  locator.registerFactory(() => GetMovieListUC(locator<MoviesRepository>()));

}
