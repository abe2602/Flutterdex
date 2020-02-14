import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/common/viewUtils.dart';
import 'package:state_navigation/app/presentation/favorites/favoritesBloc.dart';
import 'package:state_navigation/app/presentation/favorites/models.dart';
import 'package:state_navigation/domain/error/error.dart';

class FavoritesView extends StatefulWidget {
  final FavoritesBloc bloc;

  const FavoritesView({Key key, this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritesViewState();

  static Widget create(BuildContext context) => FavoritesView(
        bloc: Provider.of<ApplicationDI>(context).getFavoritesBloc(context),);
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    widget.bloc.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: StreamBuilder(
        stream: widget.bloc.favoriteListStream,
        builder: (context, AsyncSnapshot<List<FavoriteVM>> snapshot) {
          if (snapshot.hasData && snapshot.data.isEmpty) return loading();
          if (snapshot.hasData) return favoriteListGridLayout(snapshot.data);
          if (snapshot.hasError) {
            if (snapshot.error is NetworkException)
              return internetEmptyState(() {
                widget.bloc.loading();
                widget.bloc.getData();
              });
            else
              return Text(snapshot.error.toString());
          } else
            return loading();
        },
      ),
    );
  }

  Widget favoriteListGridLayout(List<FavoriteVM> favoriteList) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
      children: List.generate(
          favoriteList.length,
          (index) => Card(
                child: Text(favoriteList[index].id.toString()),
              )),
    );
  }
}
