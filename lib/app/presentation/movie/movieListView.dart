import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/app/presentation/movie/movieListUI.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailView.dart';
import 'package:state_navigation/domain/error/error.dart';

import '../common/viewUtils.dart';
import 'models.dart';

class MoviesListView extends StatefulWidget {
  final MovieListBloc bloc;

  static Widget create(BuildContext context) => MoviesListView(
        bloc: Provider.of<ApplicationDI>(context).getMovieListBloc(context),
      );

  const MoviesListView({Key key, this.bloc}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder(
        stream: widget.bloc.moviesListStream,
        builder: (context, AsyncSnapshot<List<MovieVM>> snapshot) {
          if (snapshot.hasData && snapshot.data.isEmpty) return loading();
          if (snapshot.hasData) return movieGridLayout(snapshot.data);
          if (snapshot.hasError) {
            if (snapshot.error is NetworkException)
              return internetEmptyState(() {
                widget.bloc.loading();
                widget.bloc.getData();
              });
            else
              return Text(snapshot.error.toString());
          } else {
            return loading();
          }
        },
      ),
    );
  }

  Widget movieGridLayout(List<MovieVM> movieList) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true, //vai ocupar os espaços que precisa e nada mais
      children: List.generate(
          movieList.length, (index) => getMovieWidget(movieList[index])),
    );
  }

  Widget movieImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }

  Widget getMovieWidget(MovieVM movie) {
    MovieDetailView movieDetailView = MovieDetailView.create(
      context,
      movie.id,
      movie.isFavorite,
    );

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => movieDetailView),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(child: movieImage(movie.url)),
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "NOME LINDO DO MEU CORAÇÃOOOOOOOOOOOOOOOOOOO",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          favoriteImageAsset(movie.isFavorite),
                          //favoriteStarImage(movie),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
