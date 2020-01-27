import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:state_navigation/app/data/model/movieDetailRM.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetail.dart';
import '../../data/mapper.dart';

class MovieDetailRDS{
  Client client = Client();
  var _baseUrl = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies/";

  Future<MovieDetail> getMovieDetail(int id) async {
    Response response;
    response = await client.get("$_baseUrl$id");

    return MovieDetailRM.fromJson(json.decode(response.body)).toVM();
  }
}