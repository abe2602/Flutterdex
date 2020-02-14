import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/data/cache/movieListCDS.dart';
import 'package:state_navigation/app/data/remote/movieDetailRDS.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
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

  MoviesRepository(
      this.movieDetailProvider, this.movieListProvider, this.cacheDataSource) {
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
    }).then((list) => locator<PublishSubject<int>>().sink.add(id));
  }

  @override
  Future<List<Favorite>> getFavoriteList() {
    return cacheDataSource
        .getHiveBox()
        .then((box) => cacheDataSource.readList(box))
        .then((list) => list
            .where((movieCM) => movieCM.isFavorite)
            .map((movieCM) => Favorite(
                id: movieCM.id,
                url: movieCM.url,
                isFavorite: movieCM.isFavorite))
            .toList());
  }
}
