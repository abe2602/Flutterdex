import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/presentation/common/locator.dart';

import '../../data/repository/moviesRepository.dart';
import 'movie.dart';

/*
* Colocar uma stream com a listagem!
* É como um Observable que pega do data e, quando a view pede, envia a listagem
* */
class MovieListBloc extends BlocBase{
  List<Movie> _moviesVM = [];
  final _moviesListPublishSubject = PublishSubject<List<Movie>>();
  Stream<List<Movie>> get moviesListStream => _moviesListPublishSubject.stream;

  void getMovieList() async{
    _moviesVM = await locator<MoviesRepository>().getMoviesList();
    _moviesListPublishSubject.sink.add((_moviesVM));
  }

  @override
  void dispose() {
    locator.unregister<MoviesRepository>();
    _moviesListPublishSubject.close();
    super.dispose();
  }
}