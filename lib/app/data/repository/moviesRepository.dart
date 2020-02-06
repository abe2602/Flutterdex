import 'package:hive/hive.dart';
import 'package:state_navigation/app/data/cache/cacheDataSource.dart';
import 'package:state_navigation/app/data/cache/movieCM.dart';
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

  MoviesRepository(this.movieDetailProvider, this.movieListProvider,
      this.cacheDataSource) {
    cacheDataSource.getHiveBox().then((box) => hiveBox = box);
  }

  Future<List<Movie>> getMoviesList() async {
    try {
      return await movieListProvider.getMovies().then((movieList) {
        hiveBox.put("moviesList", movieList.map((movie) => movie.toCM()).toList());
        return movieList;
      });
    } catch (response) {
      if (response is NetworkError)
        return cacheDataSource.getHiveBox().then((box) =>
            box.get("moviesList"))
            .then((list) => Future.value(list.cast<MovieCM>()
              .map((movieCM) => Movie(id: movieCM.id, url: movieCM.url))
              .toList().cast<Movie>()));
      return Future.error(response);
    }
  }

  Future<MovieDetail> getMovieDetail(int id) => movieDetailProvider.getMovieDetail(id);

}
