import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/app/presentation/common/di.dart';
import 'package:state_navigation/app/presentation/common/view_utils.dart';
import 'package:state_navigation/app/presentation/pokemon_detail/pokemon_detail_view.dart';
import 'package:state_navigation/app/presentation/pokemon_list/model.dart';
import 'package:state_navigation/app/presentation/pokemon_list/pokemon_list_bloc.dart';
import 'package:state_navigation/app/presentation/pokemon_list/pokemon_list_ui.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView(this.bloc);

  static Widget create(BuildContext context) => PokemonListView(
      Provider.of<ApplicationDI>(context).pokemonListBloc(context));

  final PokemonListBloc bloc;

  @override
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView>
    implements PokemonListUi {
  int page = 0;


  @override
  void initState() {
    super.initState();
    widget.bloc.getData();

    widget.bloc.scrollController.addListener(() {
      if (widget.bloc.scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.bloc.getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Pokédex'),
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: widget.bloc.pokemonListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return displayPokemons(snapshot.data);
              } else if (snapshot.hasError) {
                return Text('Erro, meu!');
              } else {
                return loading();
              }
            },
          ),
        ),
      );

  @override
  Widget displayPokemons(List<PokemonVM> pokemonList) => ListView.builder(
      controller: _scrollController,
      itemCount: pokemonList.length + 1,
      itemBuilder: (context, index) {
        if (index == pokemonList.length) {
          return const Align(
            child: CircularProgressIndicator(),
          );
        }

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => PokemonDetailView()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Text(pokemonList[index].name),
          ),
        );
      });
}
