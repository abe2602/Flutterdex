import 'package:state_navigation/domain/model/movieDetail.dart';
import 'movieDetail.dart';

extension MovieDetailDMtoVM on MovieDetail{
  MovieDetailVM toVM() => MovieDetailVM(id: this.id, url: this.url, date: this.date, voteAverage: this.voteAverage, title: this.title);
}

MovieDetailVM toVM(MovieDetail movieDetail) => movieDetail.toVM();