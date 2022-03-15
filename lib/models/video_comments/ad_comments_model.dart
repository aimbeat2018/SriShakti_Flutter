class AddCommentsModel {
  String? status;
  String? message;
  int? commentsId;

  AddCommentsModel({this.status, this.message, this.commentsId});
  AddCommentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    commentsId = json['comments_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['comments_id'] = this.commentsId;
    return data;
  }
}