import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import 'package:state_navigation/presentation/moviedetail/movieDetail.dart';
import '../../data/repository/moviesRepository.dart';

class MovieDetailBloc extends BlocBase{
  MoviesRepository repository = MoviesRepository();
  final _movieDetailPublishSubject = PublishSubject<MovieDetail>();
  Stream<MovieDetail> get movieDetailStream => _movieDetailPublishSubject.stream;

  getMovieDetail(int id) async{
    MovieDetail movieDetail = await repository.getMovieDetail(id);
    _movieDetailPublishSubject.sink.add(movieDetail);
  }

  @override
  void dispose() {
    _movieDetailPublishSubject.close();
    super.dispose();
  }
}