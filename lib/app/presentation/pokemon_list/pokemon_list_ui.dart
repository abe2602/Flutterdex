import 'package:flutter/widgets.dart';
import 'package:state_navigation/app/presentation/pokemon_list/model.dart';

abstract class PokemonListUi {
  Widget displayPokemons(List<PokemonVM> pokemonList);
}