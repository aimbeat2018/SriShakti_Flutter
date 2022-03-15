import 'home_content.dart';

class CountryListModel {
  List<AllCountry> allCountry = [];
  CountryListModel(this.allCountry);

  factory CountryListModel.fromJson(List<dynamic> parsedJson) {
    List<AllCountry> allGenereList = [];
    allGenereList = parsedJson.map((e) => AllCountry.fromJson(e)).toList();
    return CountryListModel(allGenereList);
  }
}
