import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/common/view_utils.dart';
import 'package:state_navigation/app/presentation/favorites/favorites_bloc.dart';
import 'package:state_navigation/app/presentation/favorites/models.dart';
import 'package:state_navigation/domain/error/error.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key key, this.bloc}) : super(key: key);
  final FavoritesBloc bloc;

  @override
  State<StatefulWidget> createState() => _FavoritesViewState();

  static Widget create(BuildContext context) => FavoritesView(
        bloc: Provider.of<ApplicationDI>(context).getFavoritesBloc(context),
      );
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    widget.bloc.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Favoritos'),
        ),
        body: StreamBuilder(
          stream: widget.bloc.favoriteListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isEmpty) {
              return loading();
            }
            if (snapshot.hasData) {
              return favoriteListGridLayout(snapshot.data);
            }
            if (snapshot.hasError) {
              if (snapshot.error is NoFavoritesException ||
                  snapshot.error is CacheException) {
                return noFavorites();
              } else {
                return Text(snapshot.error.toString());
              }
            } else {
              return loading();
            }
          },
        ),
      );

  Widget noFavorites() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.stars,
              size: MediaQuery.of(context).size.width / 2,
            ),
          ),
          const Center(
            child: Text('Sua lista de favoritos está vazia =l'),
          ),
          const Center(
            child: Text('Tente adicionar algum favorito e volte mais tarde!'),
          ),
        ],
      );

  Widget favoriteListGridLayout(List<FavoriteVM> favoriteList) =>
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
        children: List.generate(
            favoriteList.length,
            (index) => Card(
                  child: getMovieWidget(favoriteList[index]),
                )),
      );

  Widget getMovieWidget(FavoriteVM favoriteMovie) => Material(
        elevation: 3,
        shadowColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: internetImage(favoriteMovie.url)),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        favoriteMovie.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );
}
