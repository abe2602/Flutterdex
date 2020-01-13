import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'movieRM.dart';

class MoviesProvider{
  Client client = Client();
  final _baseUrl = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies";

  Future<List<MovieRM>> getMovies() async {
    List<MovieRM> moviesList = [];
    Response response;
    response = await client.get(_baseUrl);
    print(response.body.length);
    for(int i = 0; i < json.decode(response.body).toList().length; i++){
      moviesList.add(MovieRM.fromJson(json.decode(response.body)[i]));
    }
    return moviesList;
  }
}
