import 'package:flutter/cupertino.dart';
import 'package:state_navigation/app/data/remote/pokemon_list_rds.dart';
import 'package:state_navigation/app/data/repository/pokemon_repository.dart';
import 'package:state_navigation/app/presentation/pokemon_list/pokemon_list_bloc.dart';
import 'package:state_navigation/domain/data/pokemon_repository_data_source.dart';
import 'package:state_navigation/domain/usecase/get_pokemon_list_uc.dart';

///Tudo que está aqui dentro pode ser acessado por qualquer filho do MaterialApp
///var diProvider = Provider.of<ApplicationDI>(context); para acessar
class ApplicationDI {
  static PokemonListRDS getPokemonListRDS() => PokemonListRDS();

  PokemonListBloc pokemonListBloc(BuildContext context) =>
      PokemonListBloc(context);

  PokemonRepositoryDataSource getPokemonRepository() =>
      PokemonRepository(getPokemonListRDS());

  GetPokemonListUC getPokemonListUC() =>
      GetPokemonListUC(getPokemonRepository());
}
