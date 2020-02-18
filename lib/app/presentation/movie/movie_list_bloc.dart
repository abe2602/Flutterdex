import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/base_bloc.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/domain/usecase/get_movie_list_uc.dart';

import '../../../app/presentation/movie/models.dart';
import 'movie_mappers.dart';

/*
* Colocar uma stream com a listagem!
* É como um Observable que pega do data e, quando a view pede, envia a listagem
* */
class MovieListBloc extends BlocBase implements BaseBloc {
  MovieListBloc(this.context);

  final BuildContext context;
  final _moviesListPublishSubject = PublishSubject<List<MovieVM>>();

  Stream<List<MovieVM>> get moviesListStream => MergeStream([
        Provider.of<ApplicationDI>(context)
            .getFavoriteDataObservable()
            .stream
            .map((list) => list.map((movie) => movie.toVM()).toList())
            .doOnData((list) {
          list.sort((a, b) => a.isFavorite ? 0 : 1);
          _moviesListPublishSubject.add(list);
        }),
        _moviesListPublishSubject.stream
      ]);

  @override
  Future<void> getData({List<dynamic> params}) async =>
      Provider.of<ApplicationDI>(context)
          .getMovieListUC(context)
          .call(GetMovieListParams())
          .then((movieList) {
        final sortedList = List<MovieVM>.from(movieList?.map(movieToVM))
          ..sort((a, b) => a.isFavorite ? 0 : 1);
        _moviesListPublishSubject.add(sortedList);
      }).catchError(_moviesListPublishSubject.addError);

  @override
  void loading() => _moviesListPublishSubject.sink.add(null);

  @override
  void dispose() {
    _moviesListPublishSubject.close();
    super.dispose();
  }
}
