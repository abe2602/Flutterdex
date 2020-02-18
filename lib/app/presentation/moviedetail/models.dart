class MovieDetailVM {
  MovieDetailVM(this.id, this.voteAverage, this.title, this.url, this.date,
      this.isFavorite);

  int id;
  double voteAverage;
  String title;
  String url;
  String date;
  bool isFavorite;
}
