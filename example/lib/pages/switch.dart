import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageSwitch extends StatefulWidget {
  @override
  _PageSwitchState createState() => _PageSwitchState();
}

class _PageSwitchState extends State<PageSwitch> {
  bool _active = true;
  bool _active2 = false;

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Switch Widget',
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
                AtSwitch(
                  actived: _active,
                  margin: EdgeInsets.only(right: r.px(20)),
                  onPressed: (b) {
                    setState(() {
                      _active = !b;
                    });
                  },
                ),
                AtSwitch(
                  actived: _active,
                  margin: EdgeInsets.only(right: r.px(20)),
                  theme: AtTheme.Danger,
                  onPressed: (b) {
                    setState(() {
                      _active = !b;
                    });
                  },
                ),
                AtSwitch(
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
            children: <Widget>[
              AtCellRow(
                child: AtSwitch(
                  actived: true,
                  disabled: true,
                ),
              ),
              AtCellRow(
                child: AtSwitch(
                  actived: false,
                  disabled: true,
                ),
              )
            ],
          ),
          AtCellTitle('带提示文字(建议最多1个中文字)', marginTop: r.px(20)),
          AtCell(
            child: AtCellRow(
              child: AtSwitch(
                io: ['关', '开'],
                actived: _active,
                onPressed: (b) {
                  setState(() {
                    _active = !b;
                  });
                },
              ),
            ),
          ),
          AtCellTitle('带Icon', marginTop: r.px(20)),
          AtCell(
            child: AtCellRow(
              child: AtSwitch(
                actived: _active,
                icon: true,
                onPressed: (b) {
                  setState(() {
                    _active = !b;
                  });
                },
              ),
            ),
          ),
          AtCellTitle('和Cell结合使用', marginTop: r.px(20)),
          AtCell(
            child: AtCellRow(
              label: '打开什么什么功能',
              onPressed: onCellRowPressed,
              flexEnd: AtSwitch(actived: _active2),
            ),
          ),
        ],
      ),
    );
  }

  // cell点击
  void onCellRowPressed(_) {
    setState(() {
      _active2 = !_active2;
    });
  }
}
