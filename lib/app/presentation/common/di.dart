import 'package:state_navigation/app/presentation/favorites/favoritesBloc.dart';
import 'package:state_navigation/app/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailBloc.dart';

///Tudo que está aqui dentro pode ser acessado por qualquer filho do MaterialApp
///var diProvider = Provider.of<ApplicationDI>(context); para acessar
class ApplicationDI {
  MovieDetailBloc getMovieDetailBloc() => MovieDetailBloc();
  MovieListBloc getMovieListBloc() => MovieListBloc();
  FavoritesBloc getFavoritesBloc() => FavoritesBloc();
}