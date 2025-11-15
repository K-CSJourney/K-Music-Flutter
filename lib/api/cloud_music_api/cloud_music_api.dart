import 'apis.dart';
import 'entity/cloud_music.dart';
import 'entity/cloud_play_list.dart';
import 'entity/music_api.dart';
import 'utils/request.dart';

class CloudMusicApi {
  static Future _request(MusicApi api, {Map<String, dynamic>? data}) async {
    if (data != null) {
      api.parameters.addAll(data);
    }
    return Request.createRequest(
      method: api.method,
      host: api.host,
      path: api.path,
      data: api.parameters,
    );
  }

  /// 获取新歌列表
  static Future<List<CloudMusic>> personalizedNewsong({
    Map<String, dynamic>? data,
  }) async {
    List<CloudMusic> musics = List.empty(growable: true);

    // 获取最新音乐
    var response = await _request(Apis.personalizedNewsong, data: data);
    if (response != null && response["code"] == 200) {
      for (var element in response["result"]) {
        // 歌曲信息
        Map song = element["song"];
        List artists = song["artists"];
        musics.add(
          CloudMusic()
            ..id = element["id"].toString()
            ..name = element["name"]
            ..author = artists.map((p) => p["name"].toString()).toList()
            ..cover = element["picUrl"],
        );
      }

      /// 获取歌曲链接
      String ids = musics.map((p) => p.id).join(",");
      var musicSource = await _request(Apis.playerUrl, data: {"ids": "[$ids]"});
      if (musicSource != null && musicSource["code"] == 200) {
        for (var element in musicSource["data"]) {
          String id = element["id"].toString();
          CloudMusic cloudMusic = musics.firstWhere((p) => p.id == id);
          cloudMusic.source = element["url"];
        }
      }
    }
    return musics;
  }

  /// 获取歌单
  static Future<List<CloudPlayList>> playlist({
    Map<String, dynamic>? data,
  }) async {
    List<CloudPlayList> playlist = List.empty(growable: true);

    // 获取最新音乐
    var response = await _request(Apis.playlist, data: data);
    if (response != null && response["code"] == 200) {
      for (var element in response["playlists"]) {
        // 歌曲信息
        playlist.add(
          CloudPlayList()
            ..id = element["id"].toString()
            ..name = element["name"]
            ..author = element["creator"]["nickname"]
            ..cover = element["coverImgUrl"],
        );
      }

      /// 获取歌曲链接
      // String ids = playlist.map((p) => p.id).join(",");
      // var musicSource = await _request(Apis.playListDetail, data: {"ids": "[$ids]"});
      // if (musicSource != null && musicSource["code"] == 200) {
      //   for (var element in musicSource["data"]) {
      //     String id = element["id"].toString();
      //     CloudPlayList cloudMusic = playlist.firstWhere((p) => p.id == id);
      //     //cloudMusic.source = element["url"];
      //   }
      // }
    }
    return playlist;
  }

  /// 获取歌单详情
  static Future<List<CloudMusic>> playListDetail({
    Map<String, dynamic>? data,
  }) async {
    List<CloudMusic> playlist = List.empty(growable: true);

    // 获取最新音乐
    var response = await _request(Apis.playListDetail, data: data);
    if (response != null && response["code"] == 200) {
      var tracks = response["playlist"]["tracks"];
      for (var element in tracks) {
        // 歌曲信息
        playlist.add(
          CloudMusic()
            ..id = element["id"].toString()
            ..name = element["name"]
            ..author = [element["ar"][0]["name"]]
            ..cover = element["al"]["picUrl"],
        );
      }

      /// 获取歌曲链接
      String ids = playlist.map((p) => p.id).join(",");
      var musicSource = await _request(Apis.playerUrl, data: {"ids": "[$ids]"});
      if (musicSource != null && musicSource["code"] == 200) {
        for (var element in musicSource["data"]) {
          String id = element["id"].toString();
          CloudMusic cloudMusic = playlist.firstWhere((p) => p.id == id);
          cloudMusic.source = element["url"];
        }
      }
    }
    return playlist;
  }
}
