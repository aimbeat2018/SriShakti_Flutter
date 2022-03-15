import '../../models/videos.dart';

class FavouriteListModel {
  List<FavouriteModel>? favouriteListModel = [];
  FavouriteListModel({this.favouriteListModel});

  factory FavouriteListModel.fromJson(List<dynamic> parsedJson) {
    List<FavouriteModel> favouriteList = [];
    favouriteList = parsedJson.map((e) => FavouriteModel.fromJson(e)).toList();
    return FavouriteListModel(favouriteListModel: favouriteList);
  }
}

class FavouriteModel {
  String? videosId;
  String? title;
  String? description;
  String? slug;
  String? release;
  String? runtime;
  String? videoQuality;
  String? isTvseries;
  String? thumbnailUrl;
  String? posterUrl;
  List<Videos>? videos = [];
  List<Genre>? genre = [];
  List<Country>? country = [];
  List<Director>? director = [];

  FavouriteModel(
      {this.videosId,
      this.title,
      this.description,
      this.slug,
      this.release,
      this.runtime,
      this.videoQuality,
      this.isTvseries,
      this.thumbnailUrl,
      this.posterUrl,
      this.videos,
      this.genre,
      this.country,
      this.director});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    videosId = json['videos_id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    release = json['release'];
    runtime = json['runtime'];
    videoQuality = json['video_quality'];
    isTvseries = json['is_tvseries'];
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
    if (json['videos'] != null) {
      var jsonList = json['videos'] as List;
      jsonList.map((e) => Videos.fromJson(e)).toList().forEach((element) {
        videos!.add(element);
      });
    }
    if (json['genre'] != null) {
      var jsonList = json['genre'] as List;
      jsonList.map((e) => Genre.fromJson(e)).toList().forEach((element) {
        genre!.add(element);
      });
    }
    if (json['country'] != null) {
      var jsonList = json['country'] as List;
      jsonList.map((e) => Country.fromJson(e)).toList().forEach((element) {
        country!.add(element);
      });
    }
    if (json['director'] != null) {
      var jsonList = json['director'] as List;
      jsonList.map((e) => Director.fromJson(e)).toList().forEach((element) {
        director!.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videos_id'] = this.videosId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['release'] = this.release;
    data['runtime'] = this.runtime;
    data['video_quality'] = this.videoQuality;
    data['is_tvseries'] = this.isTvseries;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    if (this.genre != null) {
      data['genre'] = this.genre!.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country!.map((v) => v.toJson()).toList();
    }
    if (this.director != null) {
      data['director'] = this.director!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genre {
  String? genreId;
  String? name;
  String? url;

  Genre({this.genreId, this.name, this.url});

  Genre.fromJson(Map<String, dynamic> json) {
    genreId = json['genre_id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_id'] = this.genreId;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Country {
  String? countryId;
  String? name;
  String? url;

  Country({this.countryId, this.name, this.url});

  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Director {
  String? starId;
  String? name;
  String? url;
  String? imageUrl;

  Director({this.starId, this.name, this.url, this.imageUrl});

  Director.fromJson(Map<String, dynamic> json) {
    starId = json['star_id'];
    name = json['name'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['star_id'] = this.starId;
    data['name'] = this.name;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
