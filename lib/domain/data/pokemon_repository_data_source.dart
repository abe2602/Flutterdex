import 'package:state_navigation/domain/model/pokemon.dart';

abstract class PokemonRepositoryDataSource {
  Future<List<Pokemon>> getPokemonList();
}