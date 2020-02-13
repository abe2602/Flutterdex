import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/data/cache/favoriteMovieListCDS.dart';
import 'package:state_navigation/app/data/cache/movieListCDS.dart';
import 'package:state_navigation/app/presentation/movie/movie.dart';
import 'package:state_navigation/app/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailBloc.dart';
import 'package:state_navigation/domain/usecase/favoriteMovieUC.dart';
import 'package:state_navigation/domain/usecase/getMovieDetailsUC.dart';
import 'package:state_navigation/domain/usecase/getMovieListUC.dart';
import 'package:tuple/tuple.dart';
import '../../data/repository/moviesRepository.dart';
import '../../data/remote/movieDetailRDS.dart';
import '../../data/remote/movieRDS.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Repositórios
  locator.registerLazySingleton(() => MoviesRDS());
  locator.registerLazySingleton(() => MovieDetailRDS());
  locator.registerLazySingleton(() => MovieListCacheDataSource());
  locator.registerLazySingleton(() => FavoriteMovieListCDS());
  locator.registerLazySingleton(() => MoviesRepository(locator<MovieDetailRDS>(), locator<MoviesRDS>(), locator<MovieListCacheDataSource>()));

  //Use Cases
  locator.registerFactory(() => GetMovieDetailsUC(locator<MoviesRepository>()));
  locator.registerFactory(() => GetMovieListUC(locator<MoviesRepository>()));
  locator.registerFactory(() => FavoriteMovieUC(locator<MoviesRepository>()));

  locator.registerLazySingleton(() => PublishSubject<MovieDetailVM>());
  locator.registerLazySingleton(() => PublishSubject<List<MovieVM>>());
}
