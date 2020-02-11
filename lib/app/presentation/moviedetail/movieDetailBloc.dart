import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/baseBloc.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';
import 'package:state_navigation/domain/usecase/getMovieDetailsUC.dart';

import 'movieDetailMappers.dart';

/*
* Separar o widget do model;
* */

class MovieDetailBloc extends BlocBase implements BaseBloc {
  final _movieDetailPublishSubject = PublishSubject<MovieDetailVM>();
  final _favoriteMoviePublishSubject = BehaviorSubject<bool>.seeded(false);

  Stream<MovieDetailVM> get movieDetailStream =>
      _movieDetailPublishSubject.stream;

  Stream<bool> get favoriteMovieStream => _favoriteMoviePublishSubject.stream;

  @override
  void getData({int id}) async {
    await locator<GetMovieDetailsUC>()
        .call(Params(id: id))
        .then((movieDetail) => _movieDetailPublishSubject.sink
            .add(toVM(movieDetail, true)))
        .catchError((error) => _movieDetailPublishSubject.addError(error));
  }

  void favoriteMovie() {
    _favoriteMoviePublishSubject.sink.add(!_favoriteMoviePublishSubject.value);
  }

  @override
  void loading() => _movieDetailPublishSubject.sink.add(null);

  @override
  void dispose() {
    locator.unregister<GetMovieDetailsUC>();
    _movieDetailPublishSubject.close();
    _favoriteMoviePublishSubject.close();
    super.dispose();
  }
}
