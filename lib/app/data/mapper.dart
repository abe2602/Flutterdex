import '../../app/data/model/movieRM.dart';
import '../../app/presentation/movie/movie.dart';

import '../../app/data/model/movieDetailRM.dart';
import '../../app/presentation/moviedetail/movieDetail.dart';

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