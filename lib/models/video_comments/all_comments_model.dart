class AllCommentModelList {
  List<AllCommentModel>? commentsList = [];
  AllCommentModelList({this.commentsList});

  factory AllCommentModelList.fromJson(List<dynamic> parsedJson) {
    List<AllCommentModel> commentList = [];
    commentList = parsedJson.map((e) => AllCommentModel.fromJson(e)).toList();
    return AllCommentModelList(commentsList: commentList);
  }
}

class AllCommentModel {
  String? commentsId;
  String? videosId;
  String? userId;
  String? userName;
  String? userImgUrl;
  String? comments;

  AllCommentModel(
      {this.commentsId,
      this.videosId,
      this.userId,
      this.userName,
      this.userImgUrl,
      this.comments});

  AllCommentModel.fromJson(Map<String, dynamic> json) {
    commentsId = json['comments_id'];
    videosId = json['videos_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userImgUrl = json['user_img_url'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments_id'] = this.commentsId;
    data['videos_id'] = this.videosId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_img_url'] = this.userImgUrl;
    data['comments'] = this.comments;
    return data;
  }
}
