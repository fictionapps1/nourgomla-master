import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  int id;
  int status;
  int role;
  int languageId;
  int gender;
  String firstName;
  String lastName;
  String phone;
  String email;
  String password;
  int updatedBy;
  int phoneVerified;
  int isActivated;
  String fcmToken;



  User({
    this.id,
    this.languageId,
    this.gender,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.status,
    this.role,
    this.phoneVerified,
    this.updatedBy,
    this.isActivated,
    this.fcmToken,
  });

  factory User.fromJson(Map json) => _$UserFromJson(json);

  Map toJson() => _$UserToJson(this);
  Map toJsonResister() => _$UserToJsonResister(this);
  Map toJsonUpdateProfile() => _$UserToJsonUpdateProfile(this);
}
