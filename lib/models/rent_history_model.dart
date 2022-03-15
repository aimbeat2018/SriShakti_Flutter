import 'home_content.dart';

class RentHistoryModel {
  List<Movies>? movies = [];
  List<Tvseries>? tvseries = [];
  List<Events>? events = [];

  RentHistoryModel({this.movies, this.tvseries, this.events});

  RentHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['movies'] != null) {
      var jsonList = json['movies'] as List;
      jsonList.map((e) => Movies.fromJson(e)).toList().forEach((element) {
        movies!.add(element);
      });
    }
    if (json['tvseries'] != null) {
      var jsonList = json['tvseries'] as List;
      jsonList.map((e) => Tvseries.fromJson(e)).toList().forEach((element) {
        tvseries!.add(element);
      });
    }
    if (json['events'] != null) {
      var jsonList = json['events'] as List;
      jsonList.map((e) => Events.fromJson(e)).toList().forEach((element) {
        events!.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movies != null) {
      data['movies'] = this.movies!.map((v) => v.toJson()).toList();
    }
    if (this.tvseries != null) {
      data['tvseries'] = this.tvseries!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies {
  String? videosId;
  String? title;
  String? description;
  String? slug;
  String? release;
  String? isTvseries;
  String? isPaid;
  String? runtime;
  String? videoQuality;
  String? thumbnailUrl;
  String? posterUrl;

  Movies(
      {this.videosId,
      this.title,
      this.description,
      this.slug,
      this.release,
      this.isTvseries,
      this.isPaid,
      this.runtime,
      this.videoQuality,
      this.thumbnailUrl,
      this.posterUrl});

  Movies.fromJson(Map<String, dynamic> json) {
    videosId = json['videos_id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    release = json['release'];
    isTvseries = json['is_tvseries'];
    isPaid = json['is_paid'];
    runtime = json['runtime'];
    videoQuality = json['video_quality'];
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videos_id'] = this.videosId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['release'] = this.release;
    data['is_tvseries'] = this.isTvseries;
    data['is_paid'] = this.isPaid;
    data['runtime'] = this.runtime;
    data['video_quality'] = this.videoQuality;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    return data;
  }
}

class Events {
  String? eventId;
  String? eventName;
  String? description;
  String? slug;
  String? streamFrom;
  String? streamLabel;
  String? streamUrl;
  String? thumbnailUrl;
  String? posterUrl;

  Events(
      {this.eventId,
      this.eventName,
      this.description,
      this.slug,
      this.streamFrom,
      this.streamLabel,
      this.streamUrl,
      this.thumbnailUrl,
      this.posterUrl});

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    description = json['description'];
    slug = json['slug'];
    streamFrom = json['stream_from'];
    streamLabel = json['stream_label'];
    streamUrl = json['stream_url'];
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['stream_from'] = this.streamFrom;
    data['stream_label'] = this.streamLabel;
    data['stream_url'] = this.streamUrl;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    return data;
  }
}
