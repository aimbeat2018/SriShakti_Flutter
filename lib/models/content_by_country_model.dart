import 'home_content.dart';

class ContentByCountryModel {
  List<Movie> movieList = [];
  ContentByCountryModel({
    required this.movieList,
  });

  factory ContentByCountryModel.fromJson(List<dynamic> parsedJson) {
    List<Movie> allMovies = [];
    allMovies = parsedJson.map((e) => Movie.fromJson(e)).toList();
    return ContentByCountryModel(movieList: allMovies);
  }
}
