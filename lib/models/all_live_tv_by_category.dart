import '../../models/home_content.dart';

class LiveTVListModel {
  List<AllLiveTVChannels> channels = [];
  LiveTVListModel({required this.channels});

  factory LiveTVListModel.fromJson(List<dynamic> parsedJson) {
    List<AllLiveTVChannels> channelList = [];
    channelList = parsedJson.map((e) => AllLiveTVChannels.fromJson(e)).toList();
    return LiveTVListModel(channels: channelList);
  }
}

class AllLiveTVChannels {
  late String liveTVCategoryId;
  late String description;
  late String title;
  List<TvChannels> list = [];

  AllLiveTVChannels({required this.liveTVCategoryId, required this.title, required this.description, required this.list});

  AllLiveTVChannels.fromJson(Map<String, dynamic> json) {
    this.liveTVCategoryId = json['live_tv_category_id'];
    this.title = json['title'];
    this.description = json['description'];
    if (json['channels'] != null) {
      var jsonList = json['channels'] as List;
      jsonList.map((e) => TvChannels.fromJson(e)).toList().forEach((element) {
        list.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['live_tv_category_id'] = this.liveTVCategoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['channels'] = this.list.map((v) => v.toJson()).toList();
    return data;
  }
}
