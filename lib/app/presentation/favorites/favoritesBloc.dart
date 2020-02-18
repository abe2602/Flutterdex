import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/baseBloc.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/favorites/favoriteMappers.dart';
import 'package:state_navigation/app/presentation/favorites/models.dart';
import 'package:state_navigation/domain/usecase/getFavoriteList.dart';

import '../../data/mapper.dart';

class FavoritesBloc extends BlocBase implements BaseBloc {
  final BuildContext context;
  final _favoriteListPublishSubject = PublishSubject<List<FavoriteVM>>();

  FavoritesBloc(this.context);

  Stream<List<FavoriteVM>> get favoriteListStream => MergeStream([
        Provider.of<ApplicationDI>(context)
            .getFavoriteDataObservable()
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
  void getData({List params}) async => await Provider.of<ApplicationDI>(context)
      .getFavoriteListUC(context)
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
