import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' show Client, Response;

class BaseRDS {
  BaseRDS() {
    client = Client();
  }

  @protected
  Client client;
  @protected
  Response response;
  @protected
  String baseUrl = 'https://pokeapi.co/api/v2/';
  @protected
  ConnectivityResult connectivityResult;
}
