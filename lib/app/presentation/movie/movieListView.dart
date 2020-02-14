import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/common/locator.dart';
import 'package:state_navigation/app/presentation/movie/movieListBloc.dart';
import 'package:state_navigation/app/presentation/movie/movieListUI.dart';
import 'package:state_navigation/app/presentation/moviedetail/movieDetailView.dart';
import 'package:state_navigation/domain/error/error.dart';

import '../common/viewUtils.dart';
import 'models.dart';

class MoviesListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviesList();
}

class _MoviesList extends State<MoviesListView> implements MovieListUI {
  MovieListBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<ApplicationDI>(context).getMovieListBloc();
    bloc.getData();

    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder(
        stream: bloc.moviesListStream,
        builder: (context, AsyncSnapshot<List<MovieVM>> snapshot) {
          if (snapshot.hasData && snapshot.data.isEmpty) return loading();
          if (snapshot.hasData) return movieGridLayout(snapshot.data);
          if (snapshot.hasError) {
            if (snapshot.error is NetworkException)
              return internetEmptyState(() {
                bloc.loading();
                bloc.getData();
              });
            else
              return Text(snapshot.error.toString());
          } else
            return loading();
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

  Widget getMovieWidget(MovieVM movie) {
    MovieDetailView movieDetailView = MovieDetailView(
      id: movie.id,
      isFavorite: movie.isFavorite,
    );

    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => movieDetailView),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: CachedNetworkImage(
                    imageUrl: movie.url,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            StreamBuilder(
                stream: locator<PublishSubject<int>>().stream,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.data ==
                      movie
                          .id) //preciso dessa verificação para filtrar quando o favoritos é atualizado
                    return favoriteImageAsset(movie.isFavorite);
                  else
                    return favoriteImageAsset(movie.isFavorite);
                }),
          ],
        ),
      ),
    );
  }
}
