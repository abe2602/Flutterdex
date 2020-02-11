import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favoritos"),),
      body: Text("Favoritos"),
    );
  }

}