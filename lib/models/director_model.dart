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