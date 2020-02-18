import 'package:hive/hive.dart';

part 'movieCM.g.dart';

@HiveType(typeId: 1)
class MovieCM {
  @HiveField(0)
  int id;
  @HiveField(1)
  String url;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool isFavorite;

  MovieCM(this.id, this.url, this.title, this.isFavorite);
}
