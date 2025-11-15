import 'package:k_music_flutter/entity/music_source_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_source.g.dart';

@JsonSerializable()
class MusicSource {
  // 唯一标识
  final String id;

  // 播放源类型
  final MusicSourceType type;

  // 登录数据
  final dynamic data;

  const MusicSource({
    this.data,
    required this.id,
    required this.type,
  });

  factory MusicSource.fromJson(Map<String, dynamic> json) =>
      _$MusicSourceFromJson(json);

  Map<String, dynamic> toJson() => _$MusicSourceToJson(this);
}
