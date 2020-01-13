import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../moviedetail/movieDetailView.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Movie extends StatelessWidget{
  final int id;
  final String url;

  const Movie({Key key, @required this.id, this.url}) :
        assert(id != null),
        assert(url != null),
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