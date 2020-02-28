import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:state_navigation/app/data/model/pokemon_rm.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/pokemon.dart';

import '../../data/mapper.dart';
import 'base_rds.dart';

class PokemonListRDS extends BaseRDS {
  Future<List<Pokemon>> getPokemonList() async {
    connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException();
    } else {
      const endPoint = 'pokemon?limit=10000';
      response = await client.get('$baseUrl/$endPoint');
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
