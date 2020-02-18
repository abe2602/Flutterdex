import 'package:state_navigation/domain/model/favorite.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movie_detail.dart';

import '../../app/data/model/movie_detail_rm.dart';
import '../../app/data/model/movie_rm.dart';
import 'model/movie_cm.dart';

extension MovieRMToDM on MovieRM {
  Movie toDM() => Movie(id, url, title, false);
}

extension MovieDetailRMToDM on MovieDetailRM {
  MovieDetail toDM() => MovieDetail(
      id: id, url: url, date: date, voteAverage: voteAverage, title: title);
}

extension MovieDMToCM on Movie {
  MovieCM toCM() => MovieCM(id, url, title, isFavorite);
}

extension MovieCMToDM on MovieCM {
  Movie toDM() => Movie(id, url, title, isFavorite);
}

extension MovieCMToFavorite on MovieCM {
  Favorite toFavorite() => Favorite(id, url, title, isFavorite);
}

extension MovieDMToFavorite on Movie {
  Favorite toFavorite() => Favorite(id, url, title, isFavorite);
}
