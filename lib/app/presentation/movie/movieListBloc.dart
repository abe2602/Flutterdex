import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/domain/usecase/GetMovieListUC.dart';

import '../../../app/data/repository/moviesRepository.dart';
import '../../../app/presentation/movie/movie.dart';

/*
* Colocar uma stream com a listagem!
* É como um Observable que pega do data e, quando a view pede, envia a listagem
* */
class MovieListBloc extends BlocBase{
  final _moviesListPublishSubject = PublishSubject<List<Movie>>();
  Stream<List<Movie>> get moviesListStream => _moviesListPublishSubject.stream;

  void getMovieList() async{
    var moviesVM = await locator<GetMovieListUC>().call(Params());
    _moviesListPublishSubject.sink.add((moviesVM));
  }

  @override
  void dispose() {
    locator.unregister<MoviesRepository>();
    _moviesListPublishSubject.close();
    super.dispose();
  }
}