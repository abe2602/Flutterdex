import 'package:hive/hive.dart';

part 'movieCM.g.dart';

@HiveType(typeId: 1)
class MovieCM{
  @HiveField(0)
  int id;
  @HiveField(1)
  String url;

  MovieCM(this.id, this.url);
}