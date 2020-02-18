import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/data/cache/favorite_movie_list_cds.dart';
import 'package:state_navigation/app/data/cache/movie_list_cds.dart';
import 'package:state_navigation/app/data/remote/movie_metail_rds.dart';
import 'package:state_navigation/app/data/remote/movie_rds.dart';
import 'package:state_navigation/app/data/repository/movies_repository.dart';
import 'package:state_navigation/app/presentation/favorites/favorites_bloc.dart';
import 'package:state_navigation/app/presentation/movie/movie_list_bloc.dart';
import 'package:state_navigation/app/presentation/moviedetail/movie_detail_bloc.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/usecase/favorite_movie_uc.dart';
import 'package:state_navigation/domain/usecase/get_favorite_list.dart';
import 'package:state_navigation/domain/usecase/get_movie_details_uc.dart';
import 'package:state_navigation/domain/usecase/get_movie_list_uc.dart';

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