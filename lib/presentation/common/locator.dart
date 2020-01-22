import 'package:get_it/get_it.dart';
import '../../data/repository/moviesRepository.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => MoviesRepository());
}
