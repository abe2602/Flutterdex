import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:state_navigation/app/data/remote/base_rds.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/movie.dart';

import '../../data/mapper.dart';
import '../model/movie_rm.dart';

class MoviesRDS extends BaseRDS {
  Future<List<Movie>> getMovies() async {
    connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException();
    } else {
      response = await client.get(baseUrl);
      if (response.statusCode == 200) {
        return List<MovieRM>.from(
                json.decode(response.body).map((i) => MovieRM.fromJson(i)))
            .map((movieRM) => movieRM.toDM())
            .toList();
      } else {
        throw GenericException();
      }
    }
  }
}
