import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:state_navigation/app/data/model/pokemon_rm.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/pokemon.dart';

import '../../data/mapper.dart';
import 'base_rds.dart';

class PokemonListRDS extends BaseRDS {
  Future<List<Pokemon>> getPokemonList(int page) async {

    connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException();
    } else {
      final endPoint = 'https://pokeapi.co/api/v2/pokemon/?offset=$page&limit=20';
      response = await client.get(endPoint);
      if (response.statusCode == 200) {
        return List<PokemonRM>.from(json
                .decode(response.body)['results']
                .map((i) => PokemonRM.fromJson(i)))
            .map((pokemonRM) => pokemonRM.toDM())
            .toList();
      } else {
        throw GenericException();
      }
    }
  }
}
