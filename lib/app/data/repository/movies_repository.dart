import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/data/cache/movie_list_cds.dart';
import 'package:state_navigation/app/data/remote/movie_metail_rds.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/domain/data/movie_repository_data_source.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/favorite.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movie_detail.dart';

import '../../data/mapper.dart';
import '../../data/remote/movie_rds.dart';

class MoviesRepository extends MovieRepositoryDataSource {
  MoviesRepository(this.movieDetailProvider, this.movieListProvider,
      this.cacheDataSource, this.context) {
    cacheDataSource.getHiveBox().then((box) => hiveBox = box);
  }

  MoviesRDS movieListProvider;
  MovieDetailRDS movieDetailProvider;
  MovieListCacheDataSource cacheDataSource;
  Box hiveBox;
  BuildContext context;

  @override
  Future<List<Movie>> getMoviesList() async => cacheDataSource
          .getHiveBox()
          .then((box) => cacheDataSource.readList(box))
          .then((list) => list.map((movieCM) => movieCM.toDM()).toList())
          .catchError((error) {
        if (error is CacheException) {
          return movieListProvider.getMovies().then((movieList) {
            cacheDataSource.getHiveBox().then((box) => cacheDataSource.write(
                box,
                list: movieList.map((movie) => movie.toCM()).toList()));
            return movieList;
          });
        } else {
          throw error;
        }
      });

  @override
  Future<MovieDetail> getMovieDetail(int id) async =>
      movieDetailProvider.getMovieDetail(id).catchError((error) => throw error);

  @override
  Future<void> favoriteMovie(int id) async => cacheDataSource
          .getHiveBox()
          .then((box) => cacheDataSource.readList(box))
          .then((list) {
        list.forEach((movie) {
          if (movie.id == id) {
            movie.isFavorite = !movie.isFavorite;
          }
        });

        cacheDataSource
            .getHiveBox()
            .then((box) => cacheDataSource.write(box, list: list));

        return list.map((movieCM) => movieCM.toDM()).toList();
      }).then((list) {
        if (list.where((favorite) => favorite.isFavorite).isNotEmpty) {
          Provider.of<ApplicationDI>(context)
              .getFavoriteDataObservable()
              .sink
              .add(list.toList());
        } else {
          Provider.of<ApplicationDI>(context)
              .getFavoriteDataObservable()
              .sink
              .addError(NoFavoritesException());
        }
      });

  @override
  Future<List<Favorite>> getFavoriteList() => cacheDataSource
          .getHiveBox()
          .then((box) => cacheDataSource.readList(box))
          .then((list) {
        final favoriteList = list
            .where((movieCM) => movieCM.isFavorite)
            .map((movieCM) => movieCM.toFavorite())
            .toList();

        if (favoriteList.isEmpty) {
          throw NoFavoritesException();
        } else {
          return favoriteList;
        }
      });
}
