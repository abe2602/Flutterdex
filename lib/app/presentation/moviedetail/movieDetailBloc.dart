import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/BaseBloc.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';
import 'package:state_navigation/domain/usecase/getMovieDetailsUC.dart';

import 'movieDetailMappers.dart';

class MovieDetailBloc extends BlocBase implements BaseBloc {
  final _movieDetailPublishSubject = PublishSubject<MovieDetailVM>();

  Stream<MovieDetailVM> get movieDetailStream =>
      _movieDetailPublishSubject.stream;

  @override
  void getData({int id}) async {
    await locator<GetMovieDetailsUC>()
        .call(Params(id: id))
        .then((movieDetail) =>
            _movieDetailPublishSubject.sink.add(toVM(movieDetail)))
        .catchError((error) => _movieDetailPublishSubject.addError(error));
  }

  @override
  void loading() => _movieDetailPublishSubject.sink.add(null);

  @override
  void dispose() {
    locator.unregister<GetMovieDetailsUC>();
    _movieDetailPublishSubject.close();
    super.dispose();
  }
}
