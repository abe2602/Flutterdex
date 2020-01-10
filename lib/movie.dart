import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'movieDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Movie extends StatelessWidget{
  final int id;
  final double voteAverage;
  final String title;
  final String url;
  final String date;

  const Movie({Key key, @required this.voteAverage, @required this.id, @required this.title, this.url, this.date}) :
        assert(voteAverage != null),
        assert(id != null),
        assert(title != null),
        assert(url != null),
        assert(date != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MovieDetail(id: id)),),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}