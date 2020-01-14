import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import '../model/movieRM.dart';
import '../../presentation/movie/movie.dart';
import '../../data/mapper.dart';

class MoviesRDS{
  Client client = Client();
  final _baseUrl = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies";

  Future<List<Movie>> getMovies() async {
    List<MovieRM> moviesList = [];
    Response response;
    response = await client.get(_baseUrl);

    for(int i = 0; i < json.decode(response.body).toList().length; i++){
      moviesList.add(MovieRM.fromJson(json.decode(response.body)[i]));
    }
    return moviesList.map((movie) => movie.toVM()).toList();
  }
}
