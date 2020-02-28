import 'package:flutter/cupertino.dart';
import 'package:state_navigation/app/data/remote/pokemon_list_rds.dart';
import 'package:state_navigation/domain/data/pokemon_repository_data_source.dart';
import 'package:state_navigation/domain/model/pokemon.dart';

class PokemonRepository implements PokemonRepositoryDataSource {
  PokemonRepository(this.pokemonListProvider);

  PokemonListRDS pokemonListProvider;

  @override
  Future<List<Pokemon>> getPokemonList() async =>
      pokemonListProvider.getPokemonList();
}
