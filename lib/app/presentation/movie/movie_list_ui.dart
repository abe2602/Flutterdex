import 'package:flutter/widgets.dart';

import 'models.dart';

abstract class MovieListUI {
  Widget getMovieGridLayout(List<MovieVM> movieList);
  Widget getMovieWidget(MovieVM movie);
}
