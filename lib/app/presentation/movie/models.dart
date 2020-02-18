import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieVM {
  MovieVM(this.id, this.url, this.title, this.isFavorite);

  int id;
  String url;
  String title;
  bool isFavorite;
}
