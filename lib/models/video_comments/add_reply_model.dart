class AddReplyModel {
  String? status;
  String? message;
  int? replayId;

  AddReplyModel({this.status, this.message, this.replayId});
  AddReplyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    replayId = json['replay_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['replay_id'] = this.replayId;
    return data;
  }
}