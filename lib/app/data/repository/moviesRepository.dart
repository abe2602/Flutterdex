import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/data/cache/movieListCDS.dart';
import 'package:state_navigation/app/data/remote/movieDetailRDS.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/favorite.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';

import '../../data/mapper.dart';
import '../../data/remote/movieRDS.dart';

class MoviesRepository extends MovieRepositoryDataSource {
  MoviesRDS movieListProvider;
  MovieDetailRDS movieDetailProvider;
  MovieListCacheDataSource cacheDataSource;
  Box hiveBox;
  BuildContext context;

  MoviesRepository(this.movieDetailProvider, this.movieListProvider,
      this.cacheDataSource, this.context) {
    cacheDataSource.getHiveBox().then((box) => hiveBox = box);
  }

  Future<List<Movie>> getMoviesList() async {
    return await cacheDataSource
        .getHiveBox()
        .then((box) => cacheDataSource.readList(box))
        .then((list) => list.map((movieCM) => movieCM.toDM()).toList())
        .catchError((error) {
      if (error is CacheException)
        return movieListProvider.getMovies().then((movieList) {
          cacheDataSource.getHiveBox().then((box) => cacheDataSource.write(box,
              list: movieList.map((movie) => movie.toCM()).toList()));
          return movieList;
        });
      else
        throw error;
    });
  }

  Future<MovieDetail> getMovieDetail(int id) async => await movieDetailProvider
      .getMovieDetail(id)
      .catchError((error) => throw error);

  @override
  void favoriteMovie(int id) {
    cacheDataSource
        .getHiveBox()
        .then((box) => cacheDataSource.readList(box))
        .then((list) {
      list.forEach((movie) {
        if (movie.id == id) movie.isFavorite = !movie.isFavorite;
      });

      cacheDataSource
          .getHiveBox()
          .then((box) => cacheDataSource.write(box, list: list));

      return list.map((movieCM) => movieCM.toDM()).toList();
    })
          ..then((list) {
            if (list.where((favorite) => favorite.isFavorite).length > 0)
              Provider.of<ApplicationDI>(context)
                  .getFavoriteDataObservable()
                  .sink
                  .add(list.toList());
            else
              Provider.of<ApplicationDI>(context)
                  .getFavoriteDataObservable()
                  .sink
                  .addError(NoFavoritesException());
          });
  }

  @override
  Future<List<Favorite>> getFavoriteList() {
    return cacheDataSource
        .getHiveBox()
        .then((box) => cacheDataSource.readList(box))
        .then((list) {
      var favoriteList = list
          .where((movieCM) => movieCM.isFavorite)
          .map((movieCM) => movieCM.toFavorite())
          .toList();

      if (favoriteList.length == 0)
        throw NoFavoritesException();
      else
        return favoriteList;
    });
  }
}
