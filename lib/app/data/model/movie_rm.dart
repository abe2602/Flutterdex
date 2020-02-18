class MovieRM {
  MovieRM(this.id, this.title, this.url);

  factory MovieRM.fromJson(Map<String, dynamic> parsedJson) => MovieRM(
        parsedJson['id'],
        parsedJson['title'],
        parsedJson['poster_url'],
      );

  int id;
  String url, title;
}
