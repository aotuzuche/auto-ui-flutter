import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageLayout extends StatefulWidget {
  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Layout Widget',
        onBackPressed: () => AtRouter.pop(context),
        onClosePressed: () => AtRouter.pop(context),
        border: AtBorder.Shadow,
      ),
      body: AtLayoutBody(
        padding: EdgeInsets.symmetric(vertical: r.px(20)),
        children: <Widget>[
          AtCellTitle('Header部分'),
          AtCell(
            dividerIndent: r.px(40),
            children: <Widget>[
              AtCellRow(arrow: true, label: '左右侧挂载', value: 'addonLR', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'headline模式', value: 'button', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'border属性', value: 'button', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'title属性和child属性', value: 'button', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: '背景色', value: 'button', onPressed: onCellPressed),
            ],
          ),
          AtCellTitle('Body部分', marginTop: r.px(20)),
          AtCell(
            dividerIndent: r.px(40),
            children: <Widget>[
              AtCellRow(arrow: true, label: 'padding属性', value: 'addonLR', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'showScollBar属性', value: 'button', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'child和children属性', value: 'button', onPressed: onCellPressed),
            ],
          ),
          AtCellTitle('Footer部分', marginTop: r.px(20)),
          AtCell(
            dividerIndent: r.px(40),
            children: <Widget>[
              AtCellRow(arrow: true, label: 'header的左右侧挂载', value: 'addonLR', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'header的headline模式', value: 'button', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'header的border类型', value: 'button', onPressed: onCellPressed),
            ],
          ),
        ],
      ),
    );
  }

  // cell点击
  void onCellPressed(p) {
    Widget page;
    print(p);
    switch (p) {
      case 'layout':
        page = PageLayout();
        break;
    }
    if (page != null) {
      AtRouter.push(context, page);
    }
  }
}
