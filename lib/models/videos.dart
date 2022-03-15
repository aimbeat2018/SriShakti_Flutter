class Videos {
  String? videoFileId;
  String? label;
  String? streamKey;
  String? fileType;
  String? fileUrl;

  Videos(
      {this.videoFileId,
        this.label,
        this.streamKey,
        this.fileType,
        this.fileUrl});

  Videos.fromJson(Map<String, dynamic> json) {
    videoFileId = json['video_file_id'];
    label = json['label'];
    streamKey = json['stream_key'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_file_id'] = this.videoFileId;
    data['label'] = this.label;
    data['stream_key'] = this.streamKey;
    data['file_type'] = this.fileType;
    data['file_url'] = this.fileUrl;
    return data;
  }
}