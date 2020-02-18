import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/baseBloc.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/domain/usecase/getMovieListUC.dart';

import '../../../app/presentation/movie/models.dart';
import 'movieMappers.dart';

/*
* Colocar uma stream com a listagem!
* É como um Observable que pega do data e, quando a view pede, envia a listagem
* */
class MovieListBloc extends BlocBase implements BaseBloc {
  final BuildContext context;
  final _moviesListPublishSubject = PublishSubject<List<MovieVM>>();

  MovieListBloc(this.context);

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
  void getData({List<dynamic> params}) async =>
      await Provider.of<ApplicationDI>(context)
          .getMovieListUC(context)
          .call(GetMovieListParams())
          .then((movieList) {
        var sortedList = List<MovieVM>.from(movieList?.map((movie) => movieToVM(movie)));
        sortedList.sort((a, b) => a.isFavorite ? 0 : 1);
        _moviesListPublishSubject.add(sortedList);
      }).catchError((error) => _moviesListPublishSubject.addError(error));

  @override
  void loading() => _moviesListPublishSubject.sink.add(null);

  @override
  void dispose() {
    _moviesListPublishSubject.close();
    super.dispose();
  }
}
