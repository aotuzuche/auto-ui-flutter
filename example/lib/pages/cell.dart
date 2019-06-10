import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageCell extends StatefulWidget {
  @override
  _PageCellState createState() => _PageCellState();
}

class _PageCellState extends State<PageCell> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Cell Widget',
        onBackPressed: () => AtRouter.pop(context),
      ),
      body: AtLayoutBody(
        padding: EdgeInsets.symmetric(vertical: r.px(20)),
        showScrollBar: true,
        children: <Widget>[
          AtCellTitle('单条内容，使用AtCell的child属性即可'),
          AtCell(
            child: AtCellRow(label: '单条内容'),
          ),
          AtCellTitle('多条内容，使用AtCell的children属性，如果同时有child和children，那child会排在children前面', marginTop: r.px(20)),
          AtCell(
            children: <Widget>[
              AtCellRow(label: '内容1'),
              AtCellRow(label: '内容2'),
              AtCellRow(label: '内容3'),
              AtCellRow(label: '内容4'),
            ],
          ),
          AtCellTitle('AtCell的dividerIndent和dividerRightIndent分别控制row之间的分割线左缩进和右缩进', marginTop: r.px(20)),
          AtCell(
            dividerIndent: r.px(40),
            dividerRightIndent: r.px(40),
            children: <Widget>[
              AtCellRow(label: '内容1'),
              AtCellRow(label: '内容2'),
              AtCellRow(label: '内容3'),
              AtCellRow(label: '内容4'),
            ],
          ),
          AtCellTitle('AtCell的border属性可以控制cell的上下border样式(该例子中可能不太明显)', marginTop: r.px(20)),
          AtCell(
            border: AtBorder.None,
            child: AtCellRow(label: '内容'),
          ),
          AtCellTitle('使用AtCellRow的arrow属性，可以显示一个向右箭头（但没有交互效果）', marginTop: r.px(20)),
          AtCell(
            children: <Widget>[
              AtCellRow(label: '内容1', arrow: true),
              AtCellRow(label: '内容2', arrow: true),
            ],
          ),
          AtCellTitle(
            '使用AtCellRow的onPressed属性，使row可以触发点击事件，并且可以使用value属性让onPressed接收相应类型的参数(dynamic类型)',
            marginTop: r.px(20),
          ),
          AtCell(
            children: <Widget>[
              AtCellRow(label: 'value=1', arrow: true, value: 1, onPressed: (v) {}),
              AtCellRow(label: 'value=2', arrow: true, value: 2, onPressed: (v) {}),
            ],
          ),
          AtCellTitle(
            'AtCellRow的label属性在最左侧，接着是child，最后是children(flexStart和flexEnd除外)',
            marginTop: r.px(20),
          ),
          AtCell(
            child: AtCellRow(
              label: 'label,',
              child: Text('child,'),
              children: <Widget>[
                Text('children,'),
                Text('children,'),
              ],
            ),
          ),
          AtCellTitle(
            'AtCellRow的flexStart在所有内容的最左侧，flexEnd在除arrow以外的最右侧',
            marginTop: r.px(20),
          ),
          AtCell(
            child: AtCellRow(
              flexStart: Container(
                width: r.px(40),
                height: r.px(40),
                color: Colors.teal,
              ),
              label: 'label',
              flexEnd: Container(
                width: r.px(40),
                height: r.px(40),
                color: Colors.blueAccent,
              ),
              arrow: true,
            ),
          ),
          AtCellTitle(
            'AtCellRow的padding属性可以重置row的内边距',
            marginTop: r.px(20),
          ),
          AtCell(
            child: AtCellRow(
              padding: EdgeInsets.all(r.px(60)),
              label: 'label',
              arrow: true,
              onPressed: (_) {},
            ),
          ),
          AtCellTitle(
            '一些例子',
            marginTop: r.px(20),
          ),
          AtCell(
            children: <Widget>[
              AtCellRow(
                label: '开关',
                flexEnd: AtSwitch(
                  onPressed: (_) {},
                  actived: true,
                ),
              ),
              AtCellRow(
                label: '勾选',
                flexEnd: AtRadio(
                  onPressed: (_) {},
                  actived: true,
                ),
              ),
              AtCellRow(
                label: '按钮',
                flexEnd: AtButton(
                  text: '发送验证码',
                  mini: true,
                  onPressed: () {},
                ),
              ),
              AtCellRow(
                child: AtButton(
                  width: r.vw() - r.px(80),
                  mini: true,
                  text: '点击',
                  onPressed: () {},
                ),
              ),
              AtCellRow(
                label: '链接带更多信息',
                arrow: true,
                onPressed: (_) {},
                flexEnd: Padding(
                  padding: EdgeInsets.only(right: r.px(10)),
                  child: Text(
                    '查看更多',
                    style: TextStyle(
                      fontSize: r.fpx(26),
                      color: AtColors.smallColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
