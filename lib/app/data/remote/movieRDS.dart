import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:state_navigation/domain/model/movie.dart';

import '../../data/mapper.dart';
import '../model/movieRM.dart';

class MoviesRDS{
  Client client = Client();
  final _baseUrl = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies";

  Future<List<Movie>> getMovies() async {
    Response response;
    response = await client.get(_baseUrl);

    return Future<List<Movie>>.value(List<MovieRM>.from(json.decode(response.body).map((i) => MovieRM.fromJson(i))).map((movieRM) => movieRM.toDM()).toList());
  }
}
