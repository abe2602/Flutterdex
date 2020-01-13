import 'model/movieRM.dart';
import '../presentation/movie/movie.dart';

extension ToVM on MovieRM{
  Movie toVM(){
    return Movie(id: this.id, url: this.url);
  }
}