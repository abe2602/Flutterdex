import 'package:hive/hive.dart';

part 'movie_cm.g.dart';
// flutter pub run build_runner build
@HiveType(typeId: 1)
class MovieCM {
  MovieCM(this.id, this.url, this.title, this.isFavorite);

  @HiveField(0)
  int id;
  @HiveField(1)
  String url;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool isFavorite;
}
