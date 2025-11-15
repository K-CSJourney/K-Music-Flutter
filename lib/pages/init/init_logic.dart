// 初始化页面
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:k_music_flutter/entity/music_source.dart';
import 'package:k_music_flutter/entity/music_source_type.dart';
import 'package:k_music_flutter/services/app_service.dart';

import '../../api/navidrome_api.dart';
import '../../entity/login/navidrome_data.dart';
import '../../helper/cache_helper.dart';
import '../../values/strings.dart';

class InitLogic extends GetxController{
  /// App 服务
  AppService appService = Get.find();

  /// 选择的音乐数据源
  MusicSourceType? type;

  bool inputOK = false;

  final serverController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    serverController.addListener(updateInputState);
    usernameController.addListener(updateInputState);
    passwordController.addListener(updateInputState);
  }

  /// 更新输入状态
  void updateInputState() {
    if (type == MusicSourceType.dmusic) {
      inputOK = true;
    } else if (serverController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      inputOK = true;
    } else {
      inputOK = false;
    }
    update();
  }

  /// 更改音乐数据源
  void changeMusicSource(MusicSourceType newType) {
    type = newType;
    updateInputState();
  }

  /// 点击启动
  void onTapStart() async {
    if (type == MusicSourceType.dmusic) {
      loginByDMusic();
    } else if (type == MusicSourceType.navidrome) {
      loginByNavidrome();
    } else {
      Get.snackbar("提示", "暂未支持");
    }
  }

  /// 官方 - 登录
  void loginByDMusic() async {
    SmartDialog.showLoading(msg: Strings.wait);
    await appService.inited();
    await CacheHelper.setSourceId(MusicSourceType.dmusic.id);
    SmartDialog.dismiss();
    // Get.offAll(
    //       () => FramePage(),
    //   arguments: {"route": MusicSourceType.dmusic.route},
    // );
  }

  /// 导航者 - 登录
  void loginByNavidrome() async {
    String server = serverController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // 如果没有数据就初始化
    List<MusicSource> sourceList =
        await CacheHelper.getSourceList() ?? List.empty(growable: true);
    if (sourceList.any((p) => p.id == server)) {
      SmartDialog.showToast("已存在该服务器");
      return;
    }

    SmartDialog.showLoading(msg: Strings.wait);
    NavidromeData data = NavidromeData(
      server: server,
      user: username,
      password: password,
    );
    var result = await NavidromeApi.ping(data);
    if (result.status) {
      sourceList.add(
        MusicSource(
          id: server,
          data: data,
          type: MusicSourceType.navidrome,
        ),
      );
      await appService.inited();
      await CacheHelper.setSourceList(sourceList);
      await CacheHelper.setSourceId(server);
      SmartDialog.dismiss();
      SmartDialog.showToast("连接成功");
      // Get.offAll(
      //       () => FramePage(),
      //   arguments: {"route": MusicSourceType.navidrome.route},
      // );
    } else {
      SmartDialog.dismiss();
      SmartDialog.showToast(result.msg ?? "连接失败");
    }
  }

  @override
  void onClose() {
    serverController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}