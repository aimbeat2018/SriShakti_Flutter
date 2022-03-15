class EventsListModel {
  List<EventsModel> eventsList = [];
  EventsListModel(this.eventsList);

  factory EventsListModel.fromJson(List<dynamic> parsedJson) {
    List<EventsModel> eventsList = [];
    eventsList = parsedJson.map((e) => EventsModel.fromJson(e)).toList();
    return new EventsListModel(eventsList);
  }
}

class EventsModel {
  String? eventId;
  String? eventName;
  String? isPaid;
  String? price;
  String? description;
  String? slug;
  String? streamFrom;
  String? streamLabel;
  String? streamUrl;
  String? thumbnailUrl;
  String? posterUrl;

  EventsModel(
      {this.eventId,
      this.eventName,
      this.isPaid,
      this.price,
      this.description,
      this.slug,
      this.streamFrom,
      this.streamLabel,
      this.streamUrl,
      this.thumbnailUrl,
      this.posterUrl});

  EventsModel.fromJson(json) {
    eventId = json["event_id"];
    eventName = json["event_name"];
    isPaid = json["is_paid"];
    price = json["price"];
    description = json["description"];
    slug = json["slug"];
    streamFrom = json["stream_from"];
    streamLabel = json["stream_label"];
    streamUrl = json["stream_url"];
    thumbnailUrl = json["thumbnail_url"];
    posterUrl = json["poster_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["event_id"] = eventId;
    map["event_name"] = eventName;
    map["is_paid"] = isPaid;
    map["price"] = price;
    map["description"] = description;
    map["slug"] = slug;
    map["stream_from"] = streamFrom;
    map["stream_label"] = streamLabel;
    map["stream_url"] = streamUrl;
    map["thumbnail_url"] = thumbnailUrl;
    map["poster_url"] = posterUrl;
    return map;
  }
}
