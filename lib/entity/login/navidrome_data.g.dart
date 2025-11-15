// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navidrome_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavidromeData _$NavidromeDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NavidromeData', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['server', 'user', 'password']);
      final val = NavidromeData(
        server: $checkedConvert('server', (v) => v as String),
        user: $checkedConvert('user', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$NavidromeDataToJson(NavidromeData instance) =>
    <String, dynamic>{
      'server': instance.server,
      'user': instance.user,
      'password': instance.password,
    };
