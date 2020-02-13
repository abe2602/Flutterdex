import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/baseBloc.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/domain/usecase/getMovieListUC.dart';

import '../../../app/presentation/movie/movie.dart';
import 'movieMappers.dart';

/*
* Colocar uma stream com a listagem!
* É como um Observable que pega do data e, quando a view pede, envia a listagem
* */
class MovieListBloc extends BlocBase implements BaseBloc {
  final _moviesListPublishSubject = PublishSubject<List<MovieVM>>();

  Stream<List<MovieVM>> get moviesListStream =>
      MergeStream([_moviesListPublishSubject.stream, locator<PublishSubject<List<MovieVM>>>().stream]);

  @override
  void getData({List<dynamic> params}) async =>
      await locator<GetMovieListUC>().call(Params()).then((movieList) {
        if (movieList != null) {
          var moviesVM =
              List<MovieVM>.from(movieList.map((movie) => movieToVM(movie)));
          _moviesListPublishSubject.sink.add(moviesVM);
        }
      }).catchError((error) => _moviesListPublishSubject.sink.addError(error));

  @override
  void loading() => _moviesListPublishSubject.sink.add(null);

  @override
  void dispose() {
    locator.unregister<GetMovieListUC>();
    _moviesListPublishSubject.close();
    super.dispose();
  }
}
