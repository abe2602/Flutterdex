import 'package:state_navigation/app/presentation/favorites/models.dart';
import 'package:state_navigation/domain/model/favorite.dart';

extension FavoriteDMtoVM on Favorite {
  FavoriteVM toVM() => FavoriteVM(
    id,
    url,
    title,
    isFavorite,
  );
}

FavoriteVM favoriteToVM(Favorite favorite) => favorite.toVM();