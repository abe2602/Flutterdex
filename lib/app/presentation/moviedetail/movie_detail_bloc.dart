import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/base_bloc.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/moviedetail/models.dart';
import 'package:state_navigation/domain/usecase/favorite_movie_uc.dart';
import 'package:state_navigation/domain/usecase/get_movie_details_uc.dart';

import 'movie_detail_mappers.dart';

class MovieDetailBloc extends BlocBase implements BaseBloc {
  MovieDetailBloc(this.context);

  final BuildContext context;
  final _movieDetailPublishSubject = PublishSubject<MovieDetailVM>();
  final _favoriteMoviePublishSubject = PublishSubject<bool>();

  Stream<MovieDetailVM> get movieDetailStream =>
      _movieDetailPublishSubject.stream;

  Stream<bool> get favoriteMovieStream => _favoriteMoviePublishSubject.stream;

  @override
  Future<void> getData({List<dynamic> params}) async{
    await Provider.of<ApplicationDI>(context)
        .getMovieDetailsUC(context)
        .call(GetMovieDetailsParams(id: params[0]))
        .then((movieDetail) => _movieDetailPublishSubject.sink
            .add(movieDetailToVM(movieDetail, params[1])))
        .catchError(_movieDetailPublishSubject.addError);
  }

  void favoriteMovie(MovieDetailVM movieDetail)  {
     Provider.of<ApplicationDI>(context)
        .favoriteMovieUC(context)
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
