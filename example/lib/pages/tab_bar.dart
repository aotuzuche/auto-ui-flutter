import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageTabBar extends StatefulWidget {
  @override
  _PageTabBarState createState() => _PageTabBarState();
}

class _PageTabBarState extends State<PageTabBar> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'TabBar Widget',
        onBackPressed: () => AtRouter.pop(context),
        border: AtBorder.Shadow,
        addonBottom: AtTabBar(
          controller: tabController,
          tabs: ['Tab A', 'Tab B', 'Tab C'],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          AtLayoutBody(
            padding: EdgeInsets.symmetric(vertical: r.px(20)),
            child: Center(child: Text('第一个Tab')),
          ),
          AtLayoutBody(
            padding: EdgeInsets.symmetric(vertical: r.px(20)),
            child: Center(child: Text('第二个Tab')),
          ),
          AtLayoutBody(
            scrollable: false,
            padding: EdgeInsets.symmetric(vertical: r.px(20)),
            child: Center(child: Text('第三个Tab')),
          ),
        ],
      ),
    );
  }
}
