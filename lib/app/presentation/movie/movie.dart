import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/moviedetail/movieDetailView.dart';

class MovieVM {
  int id;
  String url;
  bool isFavorite;

  MovieVM({@required this.id, this.url, this.isFavorite});
}
