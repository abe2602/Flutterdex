import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetail extends StatelessWidget{
  final int id;
  final double voteAverage;
  final String title;
  final String url;
  final String date;

  const MovieDetail({Key key, @required this.id, @required this.voteAverage, @required this.title, @required this.url, @required this.date}) :
        assert(id != null),
        assert(voteAverage != null),
        assert(title != null),
        assert(date != null),
        assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: url,
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  Text(title),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}