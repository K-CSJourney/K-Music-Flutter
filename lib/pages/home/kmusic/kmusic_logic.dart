import 'package:get/get.dart';

import '../../../api/cloud_music_api/cloud_music_api.dart';
import '../../../api/cloud_music_api/entity/cloud_music.dart';
import '../../../api/cloud_music_api/entity/cloud_play_list.dart';
import '../../../api/test_api.dart';
import '../../../entity/music.dart';
import '../../../services/app_service.dart';
import '../../../services/play_service.dart';

/// KMUSIC - 首页逻辑
class KMusicLogic extends GetxController with StateMixin {
  /// App 服务
  AppService appService = Get.find();

  /// 播放服务
  final PlayService playService = Get.find();

  /// 最近播放列表 // 从dmskin服务器拉取
  final List<Music> songs = List.empty(growable: true);

  /// 最近播放列表
  final List<Music> newReleases = List.empty(growable: true);

  /// 歌单
  final List<CloudPlayList> playList = List.empty(growable: true);

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() async {
    /// DMSkin 服务器的数据
    songs.addAll(TestApi.getMusicList());

    // 获取最新音乐
    List<CloudMusic> newSongsData = await CloudMusicApi.personalizedNewsong();
    for (var newSong in newSongsData) {
      newReleases.add(
        Music()
          ..author = newSong.author?.join(",") ?? ""
          ..name = newSong.name
          ..cover = newSong.cover!
          ..source = newSong.source!,
      );
    }

    // 获取最新音乐
    playList.addAll(await CloudMusicApi.playlist());

    change(null, status: RxStatus.success());
  }

  /// 点击音乐卡片
  void onTapMusic(int index) {
    playService.setPlaylist(songs, index: index);
  }

  /// 点击最最新歌曲
  void onTapRecentlyMusic(int index) {
    playService.setPlaylist(newReleases, index: index);
  }

  void onTapPlayListItem(CloudPlayList newMusic) async {
    // 获取最新音乐
    List<CloudMusic> newSongsData = await CloudMusicApi.playListDetail(
      data: {"id": newMusic.id},
    );
    List<Music> songs = List.empty(growable: true);
    for (var newSong in newSongsData) {
      songs.add(
        Music()
          ..author = newSong.author?.join(",") ?? ""
          ..name = newSong.name
          ..cover = newSong.cover!
          ..source = newSong.source,
      );
    }
    playService.setPlaylist(songs);
  }
}
