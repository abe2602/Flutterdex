class MovieRM {
  int id;
  String url, title;

  MovieRM(this.id, this.title, this.url);

  factory MovieRM.fromJson(Map<String, dynamic> parsedJson) {
    return MovieRM(
      parsedJson['id'],
      parsedJson['title'],
      parsedJson['poster_url'],
    );
  }
}
