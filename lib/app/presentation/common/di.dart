import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/data/cache/favoriteMovieListCDS.dart';
import 'package:state_navigation/app/data/cache/movieListCDS.dart';
import 'package:state_navigation/app/data/remote/movieDetailRDS.dart';
import 'package:state_navigation/app/data/remote/movieRDS.dart';
import 'package:state_navigation/app/data/repository/moviesRepository.dart';
import 'package:state_navigation/app/presentation/favorites/favoritesBloc.dart';
import 'package:state_navigation/app/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailBloc.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/usecase/favoriteMovieUC.dart';
import 'package:state_navigation/domain/usecase/getFavoriteList.dart';
import 'package:state_navigation/domain/usecase/getMovieDetailsUC.dart';
import 'package:state_navigation/domain/usecase/getMovieListUC.dart';

///Tudo que está aqui dentro pode ser acessado por qualquer filho do MaterialApp
///var diProvider = Provider.of<ApplicationDI>(context); para acessar
class ApplicationDI {
  static MoviesRDS getMovieRDS() => MoviesRDS();
  static MovieDetailRDS getMovieDetailRDS() => MovieDetailRDS();
  static MovieListCacheDataSource getMovieListCacheDataSource() => MovieListCacheDataSource();
  static FavoriteMovieListCDS getFavorites() => FavoriteMovieListCDS();
  static MoviesRepository getMoviesRepository(BuildContext context) => MoviesRepository(getMovieDetailRDS(), getMovieRDS(), getMovieListCacheDataSource(), context);
  // ignore: close_sinks
  static PublishSubject favoriteDataObservable = PublishSubject<List<Movie>>();

  MovieDetailBloc getMovieDetailBloc(BuildContext context) => MovieDetailBloc(context);
  MovieListBloc getMovieListBloc(BuildContext context) => MovieListBloc(context);
  FavoritesBloc getFavoritesBloc(BuildContext context) => FavoritesBloc(context);
  PublishSubject<List<Movie>> getFavoriteDataObservable() => favoriteDataObservable;

  GetMovieListUC getMovieListUC(BuildContext context) => GetMovieListUC(getMoviesRepository(context));
  GetFavoriteListUC getFavoriteListUC(BuildContext context) => GetFavoriteListUC(getMoviesRepository(context));
  GetMovieDetailsUC getMovieDetailsUC(BuildContext context) => GetMovieDetailsUC(getMoviesRepository(context));
  FavoriteMovieUC favoriteMovieUC(BuildContext context) => FavoriteMovieUC(getMoviesRepository(context));

}