import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget{
  final int id;

  const MovieDetail({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: InkWell(
        onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MovieDetail(id: 3)),),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("$id"),
        ),
      ),
    );
  }
}