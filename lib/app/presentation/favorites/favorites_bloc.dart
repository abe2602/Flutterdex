import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/base_bloc.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/favorites/favorite_mappers.dart';
import 'package:state_navigation/app/presentation/favorites/models.dart';
import 'package:state_navigation/domain/usecase/get_favorite_list.dart';

import '../../data/mapper.dart';

class FavoritesBloc extends BlocBase implements BaseBloc {
  FavoritesBloc(this.context);

  final BuildContext context;
  final _favoriteListPublishSubject = PublishSubject<List<FavoriteVM>>();

  Stream<List<FavoriteVM>> get favoriteListStream => MergeStream([
        Provider.of<ApplicationDI>(context)
            .getFavoriteDataObservable()
            .stream
            .map((list) => list
                .where((movie) => movie.isFavorite)
                .map((movie) => movie.toFavorite().toVM())
                .toList()),
        _favoriteListPublishSubject.stream
      ]);

  @override
  Future<void> getData({List params}) async =>
      Provider.of<ApplicationDI>(context)
          .getFavoriteListUC(context)
          .call(GetFavoriteListParams())
          .then((favoriteList) => _favoriteListPublishSubject.sink
              .add(favoriteList?.map(favoriteToVM)?.toList()))
          .catchError(_favoriteListPublishSubject.addError);

  @override
  void loading() => _favoriteListPublishSubject.sink.add(null);

  @override
  void dispose() {
    _favoriteListPublishSubject.close();
    super.dispose();
  }
}
