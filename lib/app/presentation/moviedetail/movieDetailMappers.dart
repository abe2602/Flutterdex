import 'package:state_navigation/domain/model/movieDetail.dart';

import 'models.dart';

extension MovieDetailDMtoVM on MovieDetail{
  MovieDetailVM toVM(bool isFavorite) => MovieDetailVM(this.id, this.voteAverage, this.title, this.url, this.date, isFavorite);
}

MovieDetailVM movieDetailToVM(MovieDetail movieDetail, bool isFavorite) => movieDetail.toVM(isFavorite);