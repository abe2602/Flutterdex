import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/baseBloc.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/moviedetail/models.dart';
import 'package:state_navigation/domain/usecase/favoriteMovieUC.dart';
import 'package:state_navigation/domain/usecase/getMovieDetailsUC.dart';

import 'movieDetailMappers.dart';

class MovieDetailBloc extends BlocBase implements BaseBloc {
  final BuildContext context;
  final _movieDetailPublishSubject = PublishSubject<MovieDetailVM>();
  final _favoriteMoviePublishSubject = PublishSubject<bool>();

  MovieDetailBloc(this.context);

  Stream<MovieDetailVM> get movieDetailStream =>
      _movieDetailPublishSubject.stream;

  Stream<bool> get favoriteMovieStream => _favoriteMoviePublishSubject.stream;

  @override
  void getData({List<dynamic> params}) async {
    await Provider.of<ApplicationDI>(context).getMovieDetailsUC(context)
        .call(GetMovieDetailsParams(id: params[0]))
        .then((movieDetail) => _movieDetailPublishSubject.sink
            .add(movieDetailToVM(movieDetail, params[1])))
        .catchError((error) => _movieDetailPublishSubject.addError(error));
  }

  void favoriteMovie(MovieDetailVM movieDetail) async {
    await Provider.of<ApplicationDI>(context).favoriteMovieUC(context)
        .call(FavoriteMovieParams(id: movieDetail.id));
    _favoriteMoviePublishSubject.sink.add(!movieDetail.isFavorite);
  }

  @override
  void loading() => _movieDetailPublishSubject.sink.add(null);

  @override
  void dispose() {
    _movieDetailPublishSubject.close();
    _favoriteMoviePublishSubject.close();
    super.dispose();
  }
}
