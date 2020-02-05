import 'package:flutter/widgets.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:connectivity/connectivity.dart';

class BaseRDS {
  @protected Client client;
  @protected Response response;
  @protected String baseUrl = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies";
  @protected ConnectivityResult connectivityResult;

  BaseRDS() {
    this.client = Client();
  }
}