import 'package:flutter/material.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:k_music_flutter/pages/frame/frame_logic.dart';
import 'package:k_music_flutter/pages/home/kmusic/kmusic_page.dart';

import '../../entity/music_source.dart';
import '../../helper/cache_helper.dart';
import '../../values/strings.dart';
import '../../widget/blur_widget.dart';
import '../../widget/sliver_bottom_widget.dart';
import '../../widget/theme_button.dart';
import 'widget/drawer_item.dart';
import 'widget/music_control.dart';

class FramePage extends GetView<FrameLogic> {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FrameLogic());

    /// 主题
    ThemeData theme = Theme.of(context);

    /// 底部安全区域 48
    final double bottomSafeHeight = MediaQuery.of(context).padding.bottom;

    /// 底部容器总高度
    final double barHeight = 180;

    // 底部容器整体高度 180 + 48
    final double barSafeHeight = 180 + bottomSafeHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        centerTitle: false,
        actions: [
          ThemeButton(),
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: SvgPicture.asset(
                  "assets/svgs/menus.svg",
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ),
          10.horizontalSpace,
        ],
        flexibleSpace: BlurWidget(child: SizedBox.expand()),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      endDrawer: GetBuilder<FrameLogic>(
        builder: (controller) {
          return _buildDrawer();
        },
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildNavigator(),

          /// 底部音乐控制组件
          Align(
            alignment: Alignment.bottomCenter,
            child: MusicControl(
              barHeight: barHeight,
              barSafeHeight: barSafeHeight,
              bottomSafeHeight: bottomSafeHeight,
            ),
          ),
        ],
      ),
    );
  }

  /// 局部导航
  Widget _buildNavigator() {
    return Navigator(
      key: Get.nestedKey(1),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/dmusic":
            return GetPageRoute(
              settings: settings,
              transition: Transition.fadeIn,
              page: () => KMusicPage(),
            );
          // case "/navidrome":
          //   return GetPageRoute(
          //     settings: settings,
          //     transition: Transition.fadeIn,
          //     page: () => HomeNavidromePage(),
          //   );
          default:
            return GetPageRoute(
              settings: settings,
              transition: Transition.fadeIn,
              page: () => SizedBox(),
            );
        }
      },
    );
  }

  /// 右滑菜单
  Widget _buildDrawer() {
    return BlurWidget(
      radius: BorderRadius.circular(15),
      child: Drawer(
        child: CustomScrollView(
          slivers: [
            SliverSafeArea(
              bottom: false,
              sliver: SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  itemCount: controller.sourceList.length,
                  itemBuilder: (context, index) {
                    MusicSource source = controller.sourceList[index];
                    return DrawerItem(
                      source.type.name,
                      source.type.icon,
                      controller.sourceId == source.id,
                      tag: source.id,
                      onTap: () {
                        controller.changeSource(source);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 10.verticalSpace;
                  },
                ),
              ),
            ),

            SliverBottomWidget(
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(Strings.appName), Text("V1.0.0")],
                  ),

                  FilledButton(
                    onPressed: () {
                      CacheHelper.setSourceId("");
                    },
                    child: Text("清除所有数据"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
