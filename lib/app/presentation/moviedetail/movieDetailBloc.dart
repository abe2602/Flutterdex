import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';
import 'package:state_navigation/domain/usecase/getMovieDetailsUC.dart';

import 'movieDetailMappers.dart';

class MovieDetailBloc extends BlocBase{

  final _movieDetailPublishSubject = PublishSubject<MovieDetailVM>();
  Stream<MovieDetailVM> get movieDetailStream => _movieDetailPublishSubject.stream;

  getMovieDetail(int id) async{
    MovieDetailVM movieDetail = await locator<GetMovieDetailsUC>().call(Params(id: id)).then((movieDetail) => toVM(movieDetail));
    _movieDetailPublishSubject.sink.add(movieDetail);
  }

  @override
  void dispose() {
    locator.unregister<GetMovieDetailsUC>();
    _movieDetailPublishSubject.close();
    super.dispose();
  }
}