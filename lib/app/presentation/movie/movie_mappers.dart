import 'package:state_navigation/domain/model/movie.dart';

import 'models.dart';

extension MovieDMtoVM on Movie {
  MovieVM toVM() => MovieVM(
        id,
        url,
        title,
        isFavorite,
      );
}

MovieVM movieToVM(Movie movie) => movie.toVM();
