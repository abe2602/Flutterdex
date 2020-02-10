import 'package:hive/hive.dart';
import 'package:state_navigation/app/data/cache/cacheDataSource.dart';
import 'package:state_navigation/app/data/remote/movieDetailRDS.dart';
import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';

import '../../data/mapper.dart';
import '../../data/remote/movieRDS.dart';

class MoviesRepository extends MovieRepositoryDataSource {
  MoviesRDS movieListProvider;
  MovieDetailRDS movieDetailProvider;
  CacheDataSource cacheDataSource;
  Box hiveBox;

  MoviesRepository(
      this.movieDetailProvider, this.movieListProvider, this.cacheDataSource) {
    cacheDataSource.getHiveBox().then((box) => hiveBox = box);
  }

  Future<List<Movie>> getMoviesList() async {
    return await movieListProvider.getMovies().then((movieList) {
      cacheDataSource.write(hiveBox, list: movieList.map((movie) => movie.toCM()).toList());
      return movieList;
    }).catchError((response) {
      if (response is NetworkException)
        return cacheDataSource
            .getHiveBox()
            .then((box) => cacheDataSource.readList(box))
            .then((list) => list.map((movieCM) => movieCM.toDM()).toList())
            .catchError((error) {
          if (error is CacheException)
            throw response;
          else
            throw error;
        });
      else
        throw response;
    });
  }

  Future<MovieDetail> getMovieDetail(int id) =>
      movieDetailProvider.getMovieDetail(id);
}
