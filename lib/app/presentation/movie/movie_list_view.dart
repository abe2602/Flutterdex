import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/movie/movie_list_bloc.dart';
import 'package:state_navigation/app/presentation/movie/movie_list_ui.dart';
import 'package:state_navigation/app/presentation/moviedetail/movie_detail_view.dart';
import 'package:state_navigation/domain/error/error.dart';

import '../common/view_utils.dart';
import 'models.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({Key key, this.bloc}) : super(key: key);

  static Widget create(BuildContext context) => MoviesListView(
        bloc: Provider.of<ApplicationDI>(context).getMovieListBloc(context),
      );
  final MovieListBloc bloc;

  @override
  State<StatefulWidget> createState() => _MoviesList();
}

class _MoviesList extends State<MoviesListView> implements MovieListUI {
  @override
  void initState() {
    widget.bloc.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Filmes'),
        ),
        resizeToAvoidBottomPadding: false,
        body: StreamBuilder(
          stream: widget.bloc.moviesListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isEmpty) {
              return loading();
            }
            if (snapshot.hasData) {
              return getMovieGridLayout(snapshot.data);
            }
            if (snapshot.hasError) {
              if (snapshot.error is NetworkException) {
                return internetEmptyState(() {
                  widget.bloc.loading();
                  widget.bloc.getData();
                });
              } else {
                return Text(snapshot.error.toString());
              }
            } else {
              return loading();
            }
          },
        ),
      );

  @override
  Widget getMovieGridLayout(List<MovieVM> movieList) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
        children: List.generate(
            movieList.length, (index) => getMovieWidget(movieList[index])),
      );

  @override
  Widget getMovieWidget(MovieVM movie) {
    final MovieDetailView movieDetailView = MovieDetailView.create(
      context,
      movie.id,
      movie.isFavorite,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 3,
        shadowColor: Colors.white,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => movieDetailView),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: internetImage(movie.url)),
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      favoriteImageAsset(movie.isFavorite),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
