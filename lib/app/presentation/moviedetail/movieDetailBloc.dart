import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';

import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';
import 'package:state_navigation/domain/usecase/GetMovieDetailsUC.dart';

class MovieDetailBloc extends BlocBase{

  final _movieDetailPublishSubject = PublishSubject<MovieDetail>();
  Stream<MovieDetail> get movieDetailStream => _movieDetailPublishSubject.stream;

  getMovieDetail(int id) async{
    MovieDetail movieDetail = await locator<GetMovieDetailsUC>().call(Params(id: id));
    _movieDetailPublishSubject.sink.add(movieDetail);
  }

  @override
  void dispose() {
    locator.unregister<GetMovieDetailsUC>();
    _movieDetailPublishSubject.close();
    super.dispose();
  }
}