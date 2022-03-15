class AllPackageModel {
  List<Package>? package = [];

  AllPackageModel({this.package});
  AllPackageModel.fromJson(Map<String, dynamic> json) {
    if (json['package'] != null) {
      var jsonList = json['package'] as List;
      jsonList.map((e) => Package.fromJson(e)).toList().forEach((element) {
        package!.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? planId;
  String? name;
  String? day;
  String? screens;
  String? price;
  String? status;

  Package(
      {this.planId,
      this.name,
      this.day,
      this.screens,
      this.price,
      this.status});

  Package.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    name = json['name'];
    day = json['day'];
    screens = json['screens'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['name'] = this.name;
    data['day'] = this.day;
    data['screens'] = this.screens;
    data['price'] = this.price;
    data['status'] = this.status;
    return data;
  }
}
