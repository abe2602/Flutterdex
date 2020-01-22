import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/presentation/common/locator.dart';

import 'package:state_navigation/presentation/moviedetail/movieDetail.dart';
import '../../data/repository/moviesRepository.dart';

class MovieDetailBloc extends BlocBase{

  final _movieDetailPublishSubject = PublishSubject<MovieDetail>();
  Stream<MovieDetail> get movieDetailStream => _movieDetailPublishSubject.stream;

  getMovieDetail(int id) async{
    MovieDetail movieDetail = await locator<MoviesRepository>().getMovieDetail(id);
    _movieDetailPublishSubject.sink.add(movieDetail);
  }

  @override
  void dispose() {
    locator.unregister<MoviesRepository>();
    _movieDetailPublishSubject.close();
    super.dispose();
  }
}