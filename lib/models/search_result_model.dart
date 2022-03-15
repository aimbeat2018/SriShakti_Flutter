import 'home_content.dart';

class SearchResultModel {
  List<Movie>? movie = [];
  List<Tvseries>? tvSeries = [];
  List<TvChannels>? tvChannels = [];

  SearchResultModel({this.movie, this.tvSeries, this.tvChannels});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    if (json['movie'] != null) {
      var jsonList = json['movie'] as List;
      jsonList.map((e) => Movie.fromJson(e)).toList().forEach((element) {
        movie!.add(element);
      });
    }
    if (json['tvseries'] != null) {
      var jsonList = json['tvseries'] as List;
      jsonList.map((e) => Tvseries.fromJson(e)).toList().forEach((element) {
        tvSeries!.add(element);
      });
    }
    if (json['tv_channels'] != null) {
      var jsonList = json['tv_channels'] as List;
      jsonList.map((e) => TvChannels.fromJson(e)).toList().forEach((element) {
        tvChannels!.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movie != null) {
      data['movie'] = this.movie!.map((v) => v.toJson()).toList();
    }
    if (this.tvSeries != null) {
      data['tvseries'] = this.tvSeries!.map((v) => v.toJson()).toList();
    }
    if (this.tvChannels != null) {
      data['tv_channels'] = this.tvChannels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
