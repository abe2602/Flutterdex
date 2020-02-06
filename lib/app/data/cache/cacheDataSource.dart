import 'package:hive/hive.dart';

class CacheDataSource {
  Future<Box> getHiveBox() async => Hive.openBox("movieList");
}