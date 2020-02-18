import 'package:state_navigation/domain/model/movie_detail.dart';

import 'models.dart';

extension MovieDetailDMtoVM on MovieDetail {
  MovieDetailVM toVM(bool isFavorite) =>
      MovieDetailVM(id, voteAverage, title, url, date, isFavorite);
}

MovieDetailVM movieDetailToVM(MovieDetail movieDetail, bool isFavorite) =>
    movieDetail.toVM(isFavorite);
