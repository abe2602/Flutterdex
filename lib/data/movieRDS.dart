import 'dart:convert';

import 'movieRM.dart';
import 'package:http/http.dart' as http;

Future<Stream<MovieRM>> getMovies() async {

  final client = new http.Client(); // cria nova instância do serviço
  final streamedRest = await client.send(http.Request('get', Uri.parse("https://desafio-mobile.nyc3.digitaloceanspaces.com/movies"))); //manda o request para a URL

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => MovieRM.fromJson(data));
}