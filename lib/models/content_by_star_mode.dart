import 'home_content.dart';

class ContentByStarModel {
  List<Movie> movieList = [];
  ContentByStarModel({
    required this.movieList,
  });

  factory ContentByStarModel.fromJson(List<dynamic> parsedJson) {
    List<Movie> allMovies = [];
    allMovies = parsedJson.map((e) => Movie.fromJson(e)).toList();
    return ContentByStarModel(movieList: allMovies);
  }
}
