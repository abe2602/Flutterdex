import 'model/movieRM.dart';
import '../presentation/movie/movie.dart';

import 'model/movieDetailRM.dart';
import '../presentation/moviedetail/movieDetail.dart';

extension MovieToVM on MovieRM{
  Movie toVM(){
    return Movie(id: this.id, url: this.url);
  }
}

extension MovieDetailToVM on MovieDetailRM{
  MovieDetail toVM(){
    return MovieDetail(id: this.id, url: this.url, date: this.date, voteAverage: this.voteAverage, title: this.title);
  }
}