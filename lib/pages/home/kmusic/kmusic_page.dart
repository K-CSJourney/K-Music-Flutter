import 'package:flutter/material.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:get/get.dart';

import '../../../api/cloud_music_api/entity/cloud_play_list.dart';
import '../../../entity/music.dart';
import '../../../widget/list_title_widget.dart';
import '../widget/music_new_item.dart';
import '../widget/music_recently_item.dart';
import 'kmusic_logic.dart';

class KMusicPage extends GetView<KMusicLogic> {
  const KMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(KMusicLogic());

    /// 底部安全区域 48
    final double bottomSafeHeight = MediaQuery.of(context).padding.bottom;

    // 底部容器整体高度 180 + 48
    final double barSafeHeight = 180 + bottomSafeHeight;
    return Scaffold(body: controller.obx((state) => _buildBody(barSafeHeight)));
  }

  /// Body
  Widget _buildBody(double bottomHeight) {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          minimum: EdgeInsets.only(
            // left: 15,
            // right: 15,
            bottom: bottomHeight + 20,
          ),
          sliver: SliverMainAxisGroup(
            slivers: [
              if (controller.newReleases.isNotEmpty) ...{_buildNew()},

              _buildDMusic(),

              if (controller.playList.isNotEmpty) ...{_buildPlayList()},
            ],
          ),
        ),
      ],
    );
  }

  /// DM 新歌
  Widget _buildNew() {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: ListTitleWidget(
            "NEW RELEASES", // "最新发布",
            trailingText: "See All", // "全部",
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.newReleases.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Music music = controller.newReleases[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    controller.onTapRecentlyMusic(index);
                  },
                  child: MusicRecentlyItem(music),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return 10.horizontalSpace;
              },
            ),
          ),
        ),
      ],
    );
  }

  /// DM 数据
  Widget _buildDMusic() {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: ListTitleWidget(
            "RECENTLY PLAYED", // "最新发布",
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid.builder(
            itemCount: controller.songs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 3.5,
            ),
            itemBuilder: (context, index) {
              Music music = controller.songs[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.onTapMusic(index);
                },
                child: MusicNewItem(
                  music: music.name,
                  cover: music.cover,
                  author: music.author ?? "",
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// DM 播放列表
  Widget _buildPlayList() {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: ListTitleWidget(
            "PLAY LISTED", // "播放列表",
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid.builder(
            itemCount: controller.songs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 3.5,
            ),
            itemBuilder: (context, index) {
              CloudPlayList music = controller.playList[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.onTapPlayListItem(music);
                },
                child: MusicNewItem(
                  music: music.name,
                  cover: music.cover,
                  author: music.author ?? "",
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
