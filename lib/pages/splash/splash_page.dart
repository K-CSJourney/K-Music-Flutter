import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_music_flutter/entity/music_source.dart';
import 'package:k_music_flutter/helper/cache_helper.dart';
import 'package:k_music_flutter/services/app_service.dart';

import '../init/init_page.dart';

/// 启动页
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // 放置服务
    AppService appService = Get.put(AppService());
    appService.init();
    MusicSource? source = await CacheHelper.getSource();
    if (source != null) {
      /// 跳至首页
      // Get.offAll(
      //       () => FramePage(),
      //   arguments: {"route": source.type.route},
      //   transition: Transition.fadeIn,
      // );
    } else {
      await Future.delayed(Durations.extralong4);
      Get.offAll(() => InitPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 200,
          cacheWidth: 400,
        ),
      ),
    );
  }
}
