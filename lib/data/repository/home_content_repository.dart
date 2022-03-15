import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/home_content.dart';
import '../../network/api_configuration.dart';

abstract class HomeContentRepository {
  Future<HomeContent> getHomeContentData();
}

class HomeContentRepositoryImpl implements HomeContentRepository {
  @override
  Future<HomeContent> getHomeContentData() async {
    var url = ConfigApi().getApiUrl() + "/home_content_for_android";
    var response =
        await http.get(Uri.parse(url), headers: ConfigApi().getHeaders());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      HomeContent homeContent = HomeContent.fromJson(data);
      return homeContent;
    } else {
      throw Exception();
    }
  }
}
