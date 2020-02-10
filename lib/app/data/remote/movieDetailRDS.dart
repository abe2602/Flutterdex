import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:state_navigation/app/data/model/movieDetailRM.dart';
import 'package:state_navigation/app/data/remote/baseRDS.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/movieDetail.dart';

import '../../data/mapper.dart';

class MovieDetailRDS extends BaseRDS {
  Future<MovieDetail> getMovieDetail(int id) async {
    connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return throw NetworkException();
    } else {
      response = await client.get("$baseUrl/$id");
      if (response.statusCode == 200)
        return MovieDetailRM.fromJson(json.decode(response.body)).toDM();
      else
        throw Exception(response.statusCode.toString());
    }
  }
}
