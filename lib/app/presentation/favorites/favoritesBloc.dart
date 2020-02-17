import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/baseBloc.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/favorites/favoriteMappers.dart';
import 'package:state_navigation/app/presentation/favorites/models.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/usecase/getFavoriteList.dart';
import '../../data/mapper.dart';

class FavoritesBloc extends BlocBase implements BaseBloc {
  final BuildContext context;
  final _favoriteListPublishSubject = PublishSubject<List<FavoriteVM>>();

  FavoritesBloc(this.context);

  Stream<List<FavoriteVM>> get favoriteListStream => MergeStream([
        locator<PublishSubject<List<Movie>>>()
            .stream
            .map((list) => list
                .where((movie) => movie.isFavorite)
                .map((movie) => movie.toFavorite().toVM())
                .toList())
            .doOnData((list) {
          _favoriteListPublishSubject.add(list);
        }),
        _favoriteListPublishSubject.stream
      ]);

  @override
  void getData({List params}) async => await locator<GetFavoriteListUC>()
      .call(GetFavoriteListParams())
      .then((favoriteList) => _favoriteListPublishSubject.sink.add(
          favoriteList?.map((favorite) => favoriteToVM(favorite))?.toList()));

  @override
  void loading() => _favoriteListPublishSubject.sink.add(null);

  @override
  void dispose() {
    _favoriteListPublishSubject.close();
    super.dispose();
  }
}
