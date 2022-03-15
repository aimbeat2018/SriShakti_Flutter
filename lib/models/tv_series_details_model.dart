import 'director_model.dart';

class TvSeriesDetailsModel {
  String? videosId;
  String? title;
  String? description;
  String? slug;
  String? release;
  String? runtime;
  String? videoQuality;
  String? isTvseries;
  String? isPaid;
  var enableDownload;
  String? thumbnailUrl;
  String? posterUrl;
  List<Genre>? genre = [];
  List<Country>? country = [];
  List<Director>? director = [];
  List<Writer>? writer = [];
  List<Cast>? cast = [];
  List<CastAndCrew>? castAndCrew = [];
  List<Season>? season = [];
  List<RelatedTvseries>? relatedTvseries = [];

  TvSeriesDetailsModel(
      {this.videosId,
      this.title,
      this.description,
      this.slug,
      this.release,
      this.runtime,
      this.videoQuality,
      this.isTvseries,
      this.isPaid,
      this.enableDownload,
      this.thumbnailUrl,
      this.posterUrl,
      this.genre,
      this.country,
      this.director,
      this.writer,
      this.cast,
      this.castAndCrew,
      this.season,
      this.relatedTvseries});

  TvSeriesDetailsModel.fromJson(Map<String, dynamic> json) {
    videosId = json['videos_id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    release = json['release'];
    runtime = json['runtime'];
    videoQuality = json['video_quality'];
    isTvseries = json['is_tvseries'];
    isPaid = json['is_paid'];
    enableDownload = json['enable_download'];
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
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
    if (json['writer'] != null) {
      var jsonList = json['writer'] as List;
      jsonList.map((e) => Writer.fromJson(e)).toList().forEach((element) {
        writer!.add(element);
      });
    }
    if (json['cast'] != null) {
      var jsonList = json['cast'] as List;
      jsonList.map((e) => Cast.fromJson(e)).toList().forEach((element) {
        cast!.add(element);
      });
    }
    if (json['cast_and_crew'] != null) {
      var jsonList = json['cast_and_crew'] as List;
      jsonList.map((e) => CastAndCrew.fromJson(e)).toList().forEach((element) {
        castAndCrew!.add(element);
      });
    }
    if (json['season'] != null) {
      var jsonList = json['season'] as List;
      jsonList.map((e) => Season.fromJson(e)).toList().forEach((element) {
        season!.add(element);
      });
    }
    if (json['related_tvseries'] != null) {
      var jsonList = json['related_tvseries'] as List;
      jsonList
          .map((e) => RelatedTvseries.fromJson(e))
          .toList()
          .forEach((element) {
        relatedTvseries!.add(element);
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
    data['is_paid'] = this.isPaid;
    data['enable_download'] = this.enableDownload;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    if (this.genre != null) {
      data['genre'] = this.genre!.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country!.map((v) => v.toJson()).toList();
    }
    if (this.director != null) {
      data['director'] = this.director!.map((v) => v.toJson()).toList();
    }
    if (this.writer != null) {
      data['writer'] = this.writer!.map((v) => v.toJson()).toList();
    }
    if (this.cast != null) {
      data['cast'] = this.cast!.map((v) => v.toJson()).toList();
    }
    if (this.castAndCrew != null) {
      data['cast_and_crew'] = this.castAndCrew!.map((v) => v.toJson()).toList();
    }
    if (this.season != null) {
      data['season'] = this.season!.map((v) => v.toJson()).toList();
    }
    if (this.relatedTvseries != null) {
      data['related_tvseries'] =
          this.relatedTvseries!.map((v) => v.toJson()).toList();
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

class Writer {
  String? starId;
  String? name;
  String? url;
  String? imageUrl;

  Writer({this.starId, this.name, this.url, this.imageUrl});

  Writer.fromJson(Map<String, dynamic> json) {
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

class Cast {
  String? starId;
  String? name;
  String? url;
  String? imageUrl;

  Cast({this.starId, this.name, this.url, this.imageUrl});

  Cast.fromJson(Map<String, dynamic> json) {
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

class Season {
  String? seasonsId;
  String? seasonsName;
  List<Episodes>? episodes = [];

  Season({this.seasonsId, this.seasonsName, this.episodes});

  Season.fromJson(Map<String, dynamic> json) {
    seasonsId = json['seasons_id'];
    seasonsName = json['seasons_name'];
    if (json['episodes'] != null) {
      var jsonList = json['episodes'] as List;
      jsonList.map((e) => Episodes.fromJson(e)).toList().forEach((element) {
        episodes!.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seasons_id'] = this.seasonsId;
    data['seasons_name'] = this.seasonsName;
    if (this.episodes != null) {
      data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CastAndCrew {
  String? starId;
  String? name;
  String? url;
  String? imageUrl;

  CastAndCrew({this.starId, this.name, this.url, this.imageUrl});

  CastAndCrew.fromJson(Map<String, dynamic> json) {
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

class Episodes {
  String? episodesId;
  String? episodesName;
  String? streamKey;
  String? fileType;
  String? imageUrl;
  String? fileUrl;
  List<Null>? subtitle;

  Episodes(
      {this.episodesId,
      this.episodesName,
      this.streamKey,
      this.fileType,
      this.imageUrl,
      this.fileUrl,
      this.subtitle});

  Episodes.fromJson(Map<String, dynamic> json) {
    episodesId = json['episodes_id'];
    episodesName = json['episodes_name'];
    streamKey = json['stream_key'];
    fileType = json['file_type'];
    imageUrl = json['image_url'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episodes_id'] = this.episodesId;
    data['episodes_name'] = this.episodesName;
    data['stream_key'] = this.streamKey;
    data['file_type'] = this.fileType;
    data['image_url'] = this.imageUrl;
    data['file_url'] = this.fileUrl;
    return data;
  }
}

class RelatedTvseries {
  String? videosId;
  String? genre;
  String? country;
  String? title;
  String? description;
  String? slug;
  String? release;
  String? runtime;
  String? videoQuality;
  String? thumbnailUrl;
  String? posterUrl;

  RelatedTvseries(
      {this.videosId,
      this.genre,
      this.country,
      this.title,
      this.description,
      this.slug,
      this.release,
      this.runtime,
      this.videoQuality,
      this.thumbnailUrl,
      this.posterUrl});

  RelatedTvseries.fromJson(Map<String, dynamic> json) {
    videosId = json['videos_id'];
    genre = json['genre'];
    country = json['country'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    release = json['release'];
    runtime = json['runtime'];
    videoQuality = json['video_quality'];
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videos_id'] = this.videosId;
    data['genre'] = this.genre;
    data['country'] = this.country;
    data['title'] = this.title;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['release'] = this.release;
    data['runtime'] = this.runtime;
    data['video_quality'] = this.videoQuality;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    return data;
  }
}
