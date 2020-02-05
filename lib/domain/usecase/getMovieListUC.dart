import 'package:dartz/dartz.dart';
import 'package:state_navigation/domain/data/movieRepositoryDataSource.dart';
import 'package:state_navigation/domain/error/error.dart';
import 'package:state_navigation/domain/model/movie.dart';
import 'package:state_navigation/domain/usecase/baseUseCase.dart';

class GetMovieListUC extends BaseUseCase{

  final MovieRepositoryDataSource moviesRepository;

  GetMovieListUC(this.moviesRepository);

  @override
  Future call(params) => moviesRepository.getMoviesList();

}

class Params {}