import 'package:state_navigation/domain/model/movie.dart';

import 'models.dart';

extension MovieDMtoVM on Movie {
  MovieVM toVM() => MovieVM(
        this.id,
        this.url,
        this.title,
        this.isFavorite,
      );
}

MovieVM movieToVM(Movie movie) => movie.toVM();
