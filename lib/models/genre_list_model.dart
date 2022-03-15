import 'home_content.dart';

class GenreListModel {
  List<AllGenre> genereList = [];
  GenreListModel(this.genereList);

  factory GenreListModel.fromJson(List<dynamic> parsedJson) {
    List<AllGenre> allGenereList = [];
    allGenereList = parsedJson.map((e) => AllGenre.fromJson(e)).toList();
    return GenreListModel(allGenereList);
  }
}
