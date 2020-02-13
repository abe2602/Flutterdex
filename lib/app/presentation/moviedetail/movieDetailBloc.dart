import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/baseBloc.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/movie/movie.dart';
import 'package:state_navigation/app/presentation/movie/movieMappers.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';
import 'package:state_navigation/domain/usecase/favoriteMovieUC.dart';
import 'package:state_navigation/domain/usecase/getMovieDetailsUC.dart';

import 'movieDetailMappers.dart';
import '../../presentation/movie/movieMappers.dart';

/*
* Separar o widget do model;
* */

class MovieDetailBloc extends BlocBase implements BaseBloc {
  final _movieDetailPublishSubject = PublishSubject<MovieDetailVM>();
  final _favoriteMoviePublishSubject = PublishSubject<bool>();

  Stream<MovieDetailVM> get movieDetailStream =>
      _movieDetailPublishSubject.stream;

  Stream<bool> get favoriteMovieStream => _favoriteMoviePublishSubject.stream;

  @override
  void getData({List<dynamic> params}) async {
    await locator<GetMovieDetailsUC>().call(Params(id: params[0])).then((
        movieDetail) {
      var movieDetailVM = movieDetailToVM(movieDetail, params[1]);
      _movieDetailPublishSubject.sink.add(movieDetailVM);
    }).catchError((error) => _movieDetailPublishSubject.addError(error));
  }

  void favoriteMovie(bool isFavorite, MovieDetailVM movieDetailVM) async {
    await locator<FavoriteMovieUC>().call(Params2(id: movieDetailVM.id)).then((
        list) =>
        locator <PublishSubject<List<MovieVM>>>().sink.add(
            list.map((movie) => movieToVM(movie)).toList())
    );
    _favoriteMoviePublishSubject.sink.add(!movieDetailVM.isFavorite);
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
