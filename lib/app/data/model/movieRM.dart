class MovieRM{
  int id;
  String url;

  MovieRM({this.id, this.url});

  factory MovieRM.fromJson(Map<String, dynamic> parsedJson){
    return MovieRM(
        id: parsedJson['id'],
        url : parsedJson ['poster_url'],
    );
  }
}