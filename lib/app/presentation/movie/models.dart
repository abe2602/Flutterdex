import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieVM {
  int id;
  String url;
  String title;
  bool isFavorite;

  MovieVM(this.id, this.url, this.title, this.isFavorite);
}
