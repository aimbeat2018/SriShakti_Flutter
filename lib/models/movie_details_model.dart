import 'package:oxoo/models/home_content.dart';
import '../../models/tv_series_details_model.dart';
import '../../models/videos.dart';
import 'director_model.dart';

class MovieDetailsModel {
  late String videosId;
  late String title;
  late String description;
  late String slug;
  late String release;
  late String runtime;
  late String videoQuality;
  late String isTvseries;
  late String isPaid;
  late String enableDownload;
  List<DownloadLinks>? downloadLinks = [];
  late String thumbnailUrl;
  late String posterUrl;
  List<Videos>? videos = [];
  List<Genre>? genre = [];
  List<Country>? country = [];
  List<Director>? director = [];
  List<Writer>? writer = [];
  List<Cast>? cast = [];
  List<CastAndCrew>? castAndCrew = [];
  List<Movie>? relatedMovie = [];
  String? trailerUrl;

  MovieDetailsModel(
      {required this.videosId,
      required this.title,
      required this.description,
      required this.slug,
      required this.release,
      required this.runtime,
      required this.videoQuality,
      required this.isTvseries,
      required this.isPaid,
      required this.enableDownload,
      this.downloadLinks,
      required this.thumbnailUrl,
      required this.posterUrl,
      this.videos,
      this.genre,
      this.country,
      this.director,
      this.writer,
      this.cast,
      this.castAndCrew,
      this.trailerUrl,
      this.relatedMovie});

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
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
    trailerUrl = json['trailler_youtube_source'];
    if (json['download_links'] != null) {
      var jsonList = json['download_links'] as List;
      jsonList.map((e) => DownloadLinks.fromJson(e)).toList().forEach((element) {
        downloadLinks!.add(element);
      });
    } else {
      downloadLinks = null;
    }
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
    if (json['videos'] != null) {
      var jsonList = json['videos'] as List;
      jsonList.map((e) => Videos.fromJson(e)).toList().forEach((element) {
        videos!.add(element);
      });
    } else {
      videos = null;
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
    if (json['related_movie'] != null) {
      var jsonList = json['related_movie'] as List;
      jsonList.map((e) => Movie.fromJson(e)).toList().forEach((element) {
        relatedMovie!.add(element);
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
    if (this.downloadLinks != null) {
      data['download_links'] = this.downloadLinks!.map((v) => v.toJson()).toList();
    }
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
    if (this.writer != null) {
      data['writer'] = this.writer!.map((v) => v.toJson()).toList();
    }
    if (this.cast != null) {
      data['cast'] = this.cast!.map((v) => v.toJson()).toList();
    }
    if (this.castAndCrew != null) {
      data['cast_and_crew'] = this.castAndCrew!.map((v) => v.toJson()).toList();
    }
    if (this.relatedMovie != null) {
      data['related_movie'] = this.relatedMovie!.map((v) => v.toJson()).toList();
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

class DownloadLinks {
  String? downloadLinkId;
  String? label;
  String? videosId;
  String? resolution;
  String? fileSize;
  String? downloadUrl;
  bool inAppDownload = false;

  DownloadLinks({this.downloadLinkId, this.label, this.videosId, this.resolution, this.fileSize, this.downloadUrl, required this.inAppDownload});

  DownloadLinks.fromJson(Map<String, dynamic> json) {
    downloadLinkId = json['download_link_id'];
    label = json['label'];
    videosId = json['videos_id'];
    resolution = json['resolution'];
    fileSize = json['file_size'];
    downloadUrl = json['download_url'];
    inAppDownload = json['in_app_download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['download_link_id'] = this.downloadLinkId;
    data['label'] = this.label;
    data['videos_id'] = this.videosId;
    data['resolution'] = this.resolution;
    data['file_size'] = this.fileSize;
    data['download_url'] = this.downloadUrl;
    data['in_app_download'] = this.inAppDownload;
    return data;
  }
}

class RelatedMovie {
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

  RelatedMovie(
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

  RelatedMovie.fromJson(Map<String, dynamic> json) {
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
