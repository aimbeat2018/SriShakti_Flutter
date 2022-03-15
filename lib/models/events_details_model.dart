import '../../models/events_model.dart';

class EventDetailsModel {
  String? eventId;
  String? eventName;
  String? description;
  String? slug;
  String? isPaid;
  var price;
  bool? accessable;
  var watchCount;
  String? streamFrom;
  String? streamLabel;
  String? streamUrl;
  String? thumbnailUrl;
  String? posterUrl;
  List<EventsModel>? allEventChannel = [];

  EventDetailsModel(
      {this.eventId,
      this.eventName,
      this.description,
      this.slug,
      this.isPaid,
      this.price,
      this.accessable,
      this.watchCount,
      this.streamFrom,
      this.streamLabel,
      this.streamUrl,
      this.thumbnailUrl,
      this.posterUrl,
      this.allEventChannel});

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    description = json['description'];
    slug = json['slug'];
    isPaid = json['is_paid'];
    price = json['price'];
    accessable = json['accessable'];
    watchCount = json['watch_count'];
    streamFrom = json['stream_from'];
    streamLabel = json['stream_label'];
    streamUrl = json['stream_url'];
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
    if (json['all_event_channel'] != null) {
      var jsonList = json['all_event_channel'] as List;
      jsonList
          .map((e) => EventsModel.fromJson(json))
          .toList()
          .forEach((element) {
        allEventChannel!.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['is_paid'] = this.isPaid;
    data['price'] = this.price;
    data['accessable'] = this.accessable;
    data['watch_count'] = this.watchCount;
    data['stream_from'] = this.streamFrom;
    data['stream_label'] = this.streamLabel;
    data['stream_url'] = this.streamUrl;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    if (this.allEventChannel != null) {
      data['all_event_channel'] =
          this.allEventChannel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
