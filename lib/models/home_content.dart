import 'dart:convert';
import 'package:equatable/equatable.dart';

HomeContent homeContentFromJson(String str) => HomeContent.fromJson(json.decode(str));

String homeContentToJson(HomeContent data) => json.encode(data.toJson());

class HomeContent extends Equatable {
  HomeContent({
    this.slider,
    this.popularStars,
    this.allCountry,
    this.allGenre,
    this.featuredTvChannel,
    this.latestMovies,
    this.latestTvseries,
    this.featuresGenreAndMovie,
  });

  final HomeContentSlider? slider;
  final List<PopularStars>? popularStars;
  final List<AllCountry>? allCountry;
  final List<AllGenre>? allGenre;
  final List<TvChannels>? featuredTvChannel;
  final List<Movie>? latestMovies;
  final List<Tvseries>? latestTvseries;
  final List<FeaturesGenreAndMovies>? featuresGenreAndMovie;

  factory HomeContent.fromJson(Map<String, dynamic> json) => HomeContent(
        slider: HomeContentSlider.fromJson(json["slider"]),
        popularStars: List<PopularStars>.from(json["popular_stars"].map((x) => PopularStars.fromJson(x))),
        allCountry: List<AllCountry>.from(json["all_country"].map((x) => AllCountry.fromJson(x))),
        allGenre: List<AllGenre>.from(json["all_genre"].map((x) => AllGenre.fromJson(x))),
        featuredTvChannel: List<TvChannels>.from(json["featured_tv_channel"].map((x) => TvChannels.fromJson(x))),
        latestMovies: List<Movie>.from(json["latest_movies"].map((x) => Movie.fromJson(x))),
        latestTvseries: List<Tvseries>.from(json["latest_tvseries"].map((x) => Tvseries.fromJson(x))),
        featuresGenreAndMovie: List<FeaturesGenreAndMovies>.from(json["features_genre_and_movie"].map((x) => FeaturesGenreAndMovies.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider": slider!.toJson(),
        "popular_stars": List<dynamic>.from(popularStars!.map((x) => x.toJson())),
        "all_country": List<dynamic>.from(allCountry!.map((x) => x.toJson())),
        "all_genre": List<dynamic>.from(allGenre!.map((x) => x.toJson())),
        "featured_tv_channel": List<dynamic>.from(featuredTvChannel!.map((x) => x.toJson())),
        "latest_movies": List<dynamic>.from(latestMovies!.map((x) => x.toJson())),
        "latest_tvseries": List<dynamic>.from(latestTvseries!.map((x) => x.toJson())),
        "features_genre_and_movie": List<dynamic>.from(featuresGenreAndMovie!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [slider, popularStars, allCountry, allGenre, featuredTvChannel, latestMovies, latestTvseries, featuresGenreAndMovie];

  @override
  String toString() {
    return 'HomeContent{slider: $slider, popularStars: $popularStars, allCountry: $allCountry, allGenre: $allGenre, featuredTvChannel: $featuredTvChannel, latestMovies: $latestMovies, latestTvseries: $latestTvseries, featuresGenreAndMovie: $featuresGenreAndMovie}';
  }
}

class PopularStars {
  String? starId;
  String? starName;
  String? imageUrl;

  PopularStars({this.starId, this.starName, this.imageUrl});

  PopularStars.fromJson(Map<String, dynamic> json) {
    starId = json['star_id'];
    starName = json['star_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['star_id'] = this.starId;
    data['star_name'] = this.starName;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class AllCountry {
  AllCountry({
    this.countryId,
    this.name,
    this.description,
    this.slug,
    this.url,
    this.imageUrl,
  });

  String? countryId;
  String? name;
  String? description;
  String? slug;
  String? url;
  String? imageUrl;

  factory AllCountry.fromJson(Map<String, dynamic> json) => AllCountry(
        countryId: json["country_id"] == null ? null : json["country_id"],
        name: json["name"],
        description: json["description"],
        slug: json["slug"],
        url: json["url"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId == null ? null : countryId,
        "name": name,
        "description": description,
        "slug": slug,
        "url": url,
        "image_url": imageUrl == null ? null : imageUrl,
      };
}

class AllGenre {
  AllGenre({
    this.name,
    this.description,
    this.slug,
    this.url,
    this.imageUrl,
    this.genreId,
  });

  String? genreId;
  String? name;
  String? description;
  String? slug;
  String? url;
  String? imageUrl;

  factory AllGenre.fromJson(Map<String, dynamic> json) => AllGenre(
        genreId: json["genre_id"] == null ? null : json["genre_id"],
        name: json["name"],
        description: json["description"],
        slug: json["slug"],
        url: json["url"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "genre_id": genreId == null ? null : genreId,
        "name": name,
        "description": description,
        "slug": slug,
        "url": url,
        "image_url": imageUrl == null ? null : imageUrl,
      };
}

class Movie {
  Movie({
    this.videosId,
    this.title,
    this.description,
    this.slug,
    this.release,
    this.isTvseries,
    this.isPaid,
    this.price,
    this.runtime,
    this.videoQuality,
    this.thumbnailUrl,
    this.posterUrl,
  });

  String? videosId;
  String? title;
  String? description;
  String? slug;
  String? release;
  String? isTvseries;
  String? isPaid;
  String? price;
  String? runtime;
  String? videoQuality;
  String? thumbnailUrl;
  String? posterUrl;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        videosId: json["videos_id"],
        title: json["title"],
        description: json["description"],
        slug: json["slug"],
        release: json["release"],
        isTvseries: json["is_tvseries"] == null ? null : json["is_tvseries"],
        isPaid: json["is_paid"],
        price: json["price"],
        runtime: json["runtime"],
        videoQuality: json["video_quality"],
        thumbnailUrl: json["thumbnail_url"],
        posterUrl: json["poster_url"],
      );

  Map<String, dynamic> toJson() => {
        "videos_id": videosId,
        "title": title,
        "description": description,
        "slug": slug,
        "release": release,
        "is_tvseries": isTvseries == null ? null : isTvseries,
        "is_paid": isPaid,
        "price": price,
        "runtime": runtime,
        "video_quality": videoQuality,
        "thumbnail_url": thumbnailUrl,
        "poster_url": posterUrl,
      };
}

class Tvseries {
  Tvseries({
    this.videosId,
    this.title,
    this.description,
    this.slug,
    this.release,
    this.isPaid,
    this.runtime,
    this.videoQuality,
    this.thumbnailUrl,
    this.posterUrl,
  });

  String? videosId;
  String? title;
  String? description;
  String? slug;
  String? release;
  String? isPaid;
  String? runtime;
  String? videoQuality;
  String? thumbnailUrl;
  String? posterUrl;

  factory Tvseries.fromJson(Map<String, dynamic> json) => Tvseries(
        videosId: json["videos_id"],
        title: json["title"],
        description: json["description"],
        slug: json["slug"],
        release: json["release"],
        isPaid: json["is_paid"],
        runtime: json["runtime"],
        videoQuality: json["video_quality"],
        thumbnailUrl: json["thumbnail_url"],
        posterUrl: json["poster_url"],
      );

  Map<String, dynamic> toJson() => {
        "videos_id": videosId,
        "title": title,
        "description": description,
        "slug": slug,
        "release": release,
        "is_paid": isPaid,
        "runtime": runtime,
        "video_quality": videoQuality,
        "thumbnail_url": thumbnailUrl,
        "poster_url": posterUrl,
      };
}

class TvChannels {
  TvChannels({
    required this.liveTvId,
    required this.tvName,
    required this.isPaid,
    required this.description,
    required this.slug,
    required this.streamFrom,
    required this.streamLabel,
    required this.streamUrl,
    required this.thumbnailUrl,
    required this.posterUrl,
  });

  late String liveTvId;
  late String tvName;
  late String isPaid;
  late String description;
  late String slug;
  late String streamFrom;
  late String streamLabel;
  late String streamUrl;
  late String thumbnailUrl;
  late String posterUrl;

  factory TvChannels.fromJson(Map<String, dynamic> json) => TvChannels(
        liveTvId: json["live_tv_id"],
        tvName: json["tv_name"],
        isPaid: json["is_paid"],
        description: json["description"],
        slug: json["slug"],
        streamFrom: json["stream_from"],
        streamLabel: json["stream_label"],
        streamUrl: json["stream_url"],
        thumbnailUrl: json["thumbnail_url"],
        posterUrl: json["poster_url"],
      );

  Map<String, dynamic> toJson() => {
        "live_tv_id": liveTvId,
        "tv_name": tvName,
        "is_paid": isPaid,
        "description": description,
        "slug": slug,
        "stream_from": streamFrom,
        "stream_label": streamLabel,
        "stream_url": streamUrl,
        "thumbnail_url": thumbnailUrl,
        "poster_url": posterUrl,
      };

  static List<TvChannels>? fromJsonList(jsonList) {
    return jsonList.map<TvChannels>((obj) => TvChannels.fromJson(obj)).toList();
  }
}

class Radios {
  String? radioId;
  String? radioName;
  String? description;
  String? slug;
  String? isPaid;
  String? streamFrom;
  String? streamLabel;
  String? streamUrl;
  String? thumbnailUrl;
  String? posterUrl;

  Radios(
      {this.radioId,
      this.radioName,
      this.description,
      this.slug,
      this.isPaid,
      this.streamFrom,
      this.streamLabel,
      this.streamUrl,
      this.thumbnailUrl,
      this.posterUrl});

  Radios.fromJson(Map<String, dynamic> json) {
    radioId = json['radio_id'];
    radioName = json['radio_name'];
    description = json['description'];
    slug = json['slug'];
    isPaid = json['is_paid'];
    streamFrom = json['stream_from'];
    streamLabel = json['stream_label'];
    streamUrl = json['stream_url'];
    thumbnailUrl = json['thumbnail_url'];
    posterUrl = json['poster_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['radio_id'] = this.radioId;
    data['radio_name'] = this.radioName;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['is_paid'] = this.isPaid;
    data['stream_from'] = this.streamFrom;
    data['stream_label'] = this.streamLabel;
    data['stream_url'] = this.streamUrl;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    return data;
  }
}

class FeaturesGenreAndMovies {
  FeaturesGenreAndMovies({this.genreId, this.name, this.description, this.slug, this.url, this.videos});

  String? genreId;
  String? name;
  String? description;
  String? slug;
  String? url;
  List<Movie>? videos;

  factory FeaturesGenreAndMovies.fromJson(Map<String, dynamic> json) => FeaturesGenreAndMovies(
        genreId: json["genre_id"],
        name: json["name"],
        description: json["description"],
        slug: json["slug"],
        url: json["url"],
        videos: List<Movie>.from(json["videos"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genre_id": genreId,
        "name": name,
        "description": description,
        "slug": slug,
        "url": url,
        "videos": List<dynamic>.from(videos!.map((e) => e.toJson())),
      };
}

class HomeContentSlider {
  HomeContentSlider({
    this.sliderType,
    this.slide,
  });

  String? sliderType;
  List<Slide>? slide;

  factory HomeContentSlider.fromJson(Map<String, dynamic> json) => HomeContentSlider(
        sliderType: json["slider_type"],
        slide: List<Slide>.from(json["slide"].map((x) => Slide.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider_type": sliderType,
        "slide": List<dynamic>.from(slide!.map((x) => x.toJson())),
      };
}

class Slide {
  Slide({
    this.sliderId,
    this.title,
    this.description,
    this.videoLink,
    this.imageLink,
    this.slug,
    this.publication,

    //Field when movie
    this.id,
    this.actionType,
    this.actionBtnText,
    this.actionId,
    this.actionUrl,
  });

  String? sliderId;
  String? title;
  String? description;
  String? videoLink;
  String? imageLink;
  String? slug;
  String? publication;

  //Field when movie
  String? id;
  String? actionType;
  String? actionBtnText;
  String? actionId;
  String? actionUrl;

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
        sliderId: json["slider_id"],
        title: json["title"],
        description: json["description"],
        videoLink: json["video_link"],
        imageLink: json["image_link"],
        slug: json["slug"],
        publication: json["publication"],

        //Field when movie
        id: json["id"],
        actionType: json["action_type"],
        actionBtnText: json["action_btn_text"],
        actionId: json["action_id"],
        actionUrl: json["action_url"],
      );

  Map<String, dynamic> toJson() => {
        "slider_id": sliderId,
        "title": title,
        "description": description,
        "video_link": videoLink,
        "image_link": imageLink,
        "slug": slug,
        "publication": publication,

        //Field when movie
        "id": id,
        "action_type": actionType,
        "action_btn_text": actionBtnText,
        "action_id": actionId,
        "action_url": actionUrl,
      };
}
