import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/moviedetail/movieDetailView.dart';

class MovieVM extends StatelessWidget {
  final int id;
  final String url;
  final bool isFavorite;

  MovieVM({Key key, @required this.id, this.url, this.isFavorite})
      : assert(id != null),
        assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                      builder: (context) => new MovieDetailView(id: id)),
                ),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Image.asset(
                isFavorite ? "images/favorite.png" : "images/unfavorite.png",
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
