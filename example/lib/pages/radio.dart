import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageRadio extends StatefulWidget {
  @override
  _PageRadioState createState() => _PageRadioState();
}

class _PageRadioState extends State<PageRadio> {
  bool _active = true;
  int _active2 = 1;

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Radio Widget',
        onBackPressed: () => Navigator.pop(context),
        border: AtBorder.Shadow,
      ),
      body: AtLayoutBody(
        padding: EdgeInsets.symmetric(vertical: r.px(20)),
        children: <Widget>[
          AtCellTitle('基本使用'),
          AtCell(
            child: AtCellRow(
              children: <Widget>[
                AtRadio(
                  actived: _active,
                  margin: EdgeInsets.only(right: r.px(20)),
                  onPressed: (b) {
                    setState(() {
                      _active = !b;
                    });
                  },
                ),
                AtRadio(
                  actived: _active,
                  margin: EdgeInsets.only(right: r.px(20)),
                  theme: AtTheme.Danger,
                  onPressed: (b) {
                    setState(() {
                      _active = !b;
                    });
                  },
                ),
                AtRadio(
                  actived: _active,
                  theme: AtTheme.Secondary,
                  onPressed: (b) {
                    setState(() {
                      _active = !b;
                    });
                  },
                ),
              ],
            ),
          ),
          AtCellTitle('不可用状态'),
          AtCell(
            child: AtCellRow(
              child: AtRadio(
                actived: true,
                disabled: true,
                text: '点击了也没反应...',
              ),
            ),
          ),
          AtCellTitle('带文字', marginTop: r.px(20)),
          AtCell(
            child: AtCellRow(
              children: <Widget>[
                AtRadio(
                  text: '我同意',
                  actived: _active,
                  onPressed: (b) {
                    setState(() {
                      _active = !b;
                    });
                  },
                ),
                AtLink(
                  text: '《什么什么服务协议》',
                  fontSize: r.fpx(28),
                  onPressed: () {},
                )
              ],
            ),
          ),
          AtCellTitle('和Cell结合使用', marginTop: r.px(20)),
          AtCell(
            children: <Widget>[
              AtCellRow(
                label: '选项A',
                value: 1,
                onPressed: onCellRowPressed,
                flexEnd: AtRadio(actived: _active2 == 1),
              ),
              AtCellRow(
                label: '选项B',
                value: 2,
                onPressed: onCellRowPressed,
                flexEnd: AtRadio(actived: _active2 == 2),
              ),
              AtCellRow(
                label: '选项C',
                value: 3,
                onPressed: onCellRowPressed,
                flexEnd: AtRadio(actived: _active2 == 3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // cell点击
  void onCellRowPressed(v) {
    setState(() {
      _active2 = v;
    });
  }
}
