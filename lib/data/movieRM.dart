class MovieRM{
  int id;
  double voteAverage;
  String title;
  String url;
  List<String> genres;
  String date;

  MovieRM({this.id, this.voteAverage, this.title, this.url, this.genres, this.date});

  factory MovieRM.fromJson(Map<String, dynamic> parsedJson){
    return MovieRM(
        id: parsedJson['id'],
        voteAverage : parsedJson['vote_average'],
        title : parsedJson ['title'],
        url : parsedJson ['poster_url'],
        date : parsedJson ['release_date']
    );
  }
}