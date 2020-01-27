import '../../app/data/model/movieRM.dart';
import 'package:state_navigation/domain/model/movie.dart';

import '../../app/data/model/movieDetailRM.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';

extension MovieRMToDM on MovieRM{
  Movie toDM() => Movie(id: this.id, url: this.url);
}

extension MovieDetailRMToDM on MovieDetailRM{
  MovieDetail toDM() => MovieDetail(id: this.id, url: this.url, date: this.date, voteAverage: this.voteAverage, title: this.title);

}