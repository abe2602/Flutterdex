import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/domain/usecase/getMovieListUC.dart';

import '../../../app/presentation/movie/movie.dart';
import 'movieMappers.dart';

/*
* Colocar uma stream com a listagem!
* É como um Observable que pega do data e, quando a view pede, envia a listagem
* */
class MovieListBloc extends BlocBase{
  final _moviesListPublishSubject = PublishSubject<List<MovieVM>>();
  Stream<List<MovieVM>> get moviesListStream => _moviesListPublishSubject.stream;

  void getMovieList() async {

    await locator<GetMovieListUC>().call(Params())
        .then((movieList) {
          var moviesVM = List<MovieVM>.from(movieList.map((movie) => toVM(movie)));
          _moviesListPublishSubject.sink.add(moviesVM);
        })
        .catchError((error) => _moviesListPublishSubject.sink.addError(error));
  }

  void callLoading() => _moviesListPublishSubject.sink.add(null);

  @override
  void dispose() {
    locator.unregister<GetMovieListUC>();
    _moviesListPublishSubject.close();
    super.dispose();
  }
}