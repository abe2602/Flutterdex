import 'package:state_navigation/app/presentation/favorites/models.dart';
import 'package:state_navigation/domain/model/favorite.dart';

extension FavoriteDMtoVM on Favorite {
  FavoriteVM toVM() => FavoriteVM(
    this.id,
    this.url,
    this.title,
    this.isFavorite,
  );
}

FavoriteVM favoriteToVM(Favorite favorite) => favorite.toVM();