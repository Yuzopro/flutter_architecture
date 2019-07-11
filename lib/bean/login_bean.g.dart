// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBean _$LoginBeanFromJson(Map<String, dynamic> json) {
  return LoginBean(
      json['id'] as int,
      json['url'] as String,
      json['app'] == null
          ? null
          : App.fromJson(json['app'] as Map<String, dynamic>),
      json['token'] as String,
      json['hashed_token'] as String,
      json['token_last_eight'] as String,
      json['note'] as String,
      json['created_at'] as String,
      json['updated_at'] as String,
      (json['scopes'] as List)?.map((e) => e as String)?.toList());
}

App _$AppFromJson(Map<String, dynamic> json) {
  return App(json['name'] as String, json['url'] as String,
      json['client_id'] as String);
}
