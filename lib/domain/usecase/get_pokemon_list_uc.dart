import 'package:state_navigation/domain/data/pokemon_repository_data_source.dart';
import 'package:state_navigation/domain/model/pokemon.dart';

import 'base_use_case.dart';

class GetPokemonListUC
    implements BaseUseCase<List<Pokemon>, GetPokemonListUcParams> {

  GetPokemonListUC(this.pokemonRepository);

  PokemonRepositoryDataSource pokemonRepository;

  @override
  Future<List<Pokemon>> call(GetPokemonListUcParams params) =>
      pokemonRepository.getPokemonList();
}

class GetPokemonListUcParams {}
