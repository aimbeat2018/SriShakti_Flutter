import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 9)
class AuthUser {
  @HiveField(0)
  String? status;

  @HiveField(1)
  String? userId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? imageUrl;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  String? joinDate;

  @HiveField(7)
  String? lastLogin;

  AuthUser(
      {this.status,
        this.userId,
        this.name,
        this.email,
        this.imageUrl,
        this.gender,
        this.joinDate,
        this.lastLogin});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      status: json['status'],
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['image_url'],
      gender: json['gender'],
      joinDate: json['join_date'],
      lastLogin: json['last_login'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image_url'] = this.imageUrl;
    data['gender'] = this.gender;
    data['join_date'] = this.joinDate;
    data['last_login'] = this.lastLogin;
    return data;
  }
}