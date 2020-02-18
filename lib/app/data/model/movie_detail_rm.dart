class MovieDetailRM {
  MovieDetailRM({this.id, this.voteAverage, this.title, this.url, this.date});

  factory MovieDetailRM.fromJson(Map<String, dynamic> parsedJson) =>
      MovieDetailRM(
          id: parsedJson['id'],
          voteAverage: parsedJson['vote_average'],
          title: parsedJson['title'],
          url: parsedJson['poster_url'],
          date: parsedJson['release_date']);

  int id;
  double voteAverage;
  String title;
  String url;
  String date;
}
