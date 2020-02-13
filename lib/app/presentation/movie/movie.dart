import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieVM {
  int id;
  String url;
  bool isFavorite;

  MovieVM({@required this.id, this.url, this.isFavorite});
}
