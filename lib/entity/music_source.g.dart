// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicSource _$MusicSourceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MusicSource', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['id', 'type', 'data']);
      final val = MusicSource(
        data: $checkedConvert('data', (v) => v),
        id: $checkedConvert('id', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$MusicSourceTypeEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MusicSourceToJson(MusicSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MusicSourceTypeEnumMap[instance.type]!,
      'data': instance.data,
    };

const _$MusicSourceTypeEnumMap = {
  MusicSourceType.dmusic: 'dmusic',
  MusicSourceType.navidrome: 'navidrome',
};
