import 'package:state_navigation/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/presentation/moviedetail/movieDetailBloc.dart';

///Tudo que está aqui dentro pode ser acessado por qualquer filho do MaterialApp
///var diProvider = Provider.of<ApplicationDI>(context); para acessar
class ApplicationDI {
  MovieListBloc movieListBloc = MovieListBloc();
  MovieDetailBloc movieDetailBloc = MovieDetailBloc();
}