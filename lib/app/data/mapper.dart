import 'package:state_navigation/domain/model/favorite.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';

import '../../app/data/model/movieDetailRM.dart';
import '../../app/data/model/movieRM.dart';
import 'cache/movieCM.dart';

extension MovieRMToDM on MovieRM {
  Movie toDM() => Movie(id: this.id, url: this.url, isFavorite: false);
}

extension MovieDetailRMToDM on MovieDetailRM {
  MovieDetail toDM() => MovieDetail(
      id: this.id,
      url: this.url,
      date: this.date,
      voteAverage: this.voteAverage,
      title: this.title);
}

extension MovieDMToCM on Movie {
  MovieCM toCM() => MovieCM(this.id, this.url, this.isFavorite);
}

extension MovieCMToDM on MovieCM {
  Movie toDM() =>
      Movie(id: this.id, url: this.url, isFavorite: this.isFavorite);
}

extension MovieCMToFavorite on MovieCM {
  Favorite toFavorite() =>
      Favorite(id: this.id, url: this.url, isFavorite: this.isFavorite);
}

extension MovieDMToFavorite on Movie {
  Favorite toFavorite() =>
      Favorite(id: this.id, url: this.url, isFavorite: this.isFavorite);
}
