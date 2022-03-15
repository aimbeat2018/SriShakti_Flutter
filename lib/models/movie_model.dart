class MovieListModel {
  List<MovieModel>? movieList = [];
  MovieListModel({this.movieList});

  factory MovieListModel.fromJson(List<dynamic> parsedJson) {
    List<MovieModel> movieList = [];
    movieList = parsedJson.map((e) => MovieModel.fromJson(e)).toList();
    return MovieListModel(movieList: movieList);
  }
}

class MovieModel {
  String? videosId;
  String? title;
  String? description;
  String? slug;
  String? release;
  String? isPaid;
  String? isTvseries;
  String? runtime;
  String? videoQuality;
  String? thumbnailUrl;
  String? posterUrl;

  MovieModel(
      {this.videosId,
      this.title,
      this.description,
      this.slug,
      this.release,
      this.isPaid,
      this.isTvseries,
      this.runtime,
      this.videoQuality,
      this.thumbnailUrl,
      this.posterUrl});

  MovieModel.fromJson(Map<String, dynamic> json) {
    videosId = json['videos_id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    release = json['release'];
    isPaid = json['is_paid'];
    isTvseries = json['is_tvseries'];
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
    data['is_paid'] = this.isPaid;
    data['is_tvseries'] = this.isTvseries;
    data['runtime'] = this.runtime;
    data['video_quality'] = this.videoQuality;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['poster_url'] = this.posterUrl;
    return data;
  }
}
