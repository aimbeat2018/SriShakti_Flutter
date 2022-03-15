class AllReplyModelList {
  final List<AllReplyModel> allReplyList;
  AllReplyModelList(this.allReplyList);

  factory AllReplyModelList.fromJson(List<dynamic> parsedJson) {
    List<AllReplyModel> allReplyModel = [];
    allReplyModel = parsedJson.map((e) => AllReplyModel.fromJson(e)).toList();
    return AllReplyModelList(allReplyModel);
  }
}

class AllReplyModel {
  String? replayId;
  String? videosId;
  String? userId;
  String? userName;
  String? userImgUrl;
  String? comments;

  AllReplyModel(
      {this.replayId,
      this.videosId,
      this.userId,
      this.userName,
      this.userImgUrl,
      this.comments});

  AllReplyModel.fromJson(Map<String, dynamic> json) {
    replayId = json['replay_id'];
    videosId = json['videos_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userImgUrl = json['user_img_url'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replay_id'] = this.replayId;
    data['videos_id'] = this.videosId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_img_url'] = this.userImgUrl;
    data['comments'] = this.comments;
    return data;
  }
}
