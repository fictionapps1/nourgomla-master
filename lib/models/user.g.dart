// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    languageId: json['language_id'] as int,
    gender: json['gender'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    status: json['status'] as int,
    role: json['role'] as int,
    isActivated: json['activation'] as int,
    phoneVerified: json['phone_verification'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'role': instance.role,
  'language_id': instance.languageId,
  'gender': instance.gender,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
  'password': instance.password,
  'activation': instance.isActivated,
  'phone_verification': instance.phoneVerified,
};

Map<String, dynamic> _$UserToJsonResister(User instance) => <String, dynamic>{
  'id': instance.id,
  'language_id': instance.languageId,
  'gender': instance.gender,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
  'password': instance.password,
  'vendor_id': '',
  'token': instance.fcmToken,
};

Map<String, dynamic> _$UserToJsonUpdateProfile(User instance) =>
    <String, dynamic>{
      'status': instance.status,
      'role': instance.role,
      'id': instance.id,
      'language_id': instance.languageId,
      'gender': instance.gender,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'phone_verification': instance.phoneVerified,
      'updated_by': instance.updatedBy,
      'vendor_id': '',
    };
