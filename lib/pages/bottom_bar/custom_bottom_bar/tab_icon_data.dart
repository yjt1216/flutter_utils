
class TabIconData {
  TabIconData({
    this.index = 0,
    this.title = '',
  });

  int index;
  String title;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      index: 0,
      title: '在线频道',
    ),
    TabIconData(
      index: 1,
      title: '工作台',
    ),
    TabIconData(
      index: 2,
      title: '企业网盘',
    ),
  ];
}
