/// 音乐数据源类型
enum MusicSourceType {
  // 支持官方播放源 和 本地音乐源
  dmusic("dmusic", "DMusic", "assets/images/logo.png", "/dmusic"),
  // 音乐数据源
  navidrome(
    "navidrome",
    "Navidrome",
    "assets/images/navidrome.png",
    "/navidrome",
  );

  final String id;
  final String name;
  final String route;
  final String icon;

  const MusicSourceType(this.id, this.name, this.icon, this.route);
}
