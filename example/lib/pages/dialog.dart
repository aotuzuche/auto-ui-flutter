import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageDialog extends StatefulWidget {
  @override
  _PageDialogState createState() => _PageDialogState();
}

class _PageDialogState extends State<PageDialog> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      backgroundColor: Colors.white,
      header: AtLayoutHeader(
        title: 'Dialog Widget',
        onBackPressed: () => Navigator.pop(context),
        border: AtBorder.Shadow,
      ),
      body: AtLayoutBody(
        padding: EdgeInsets.symmetric(vertical: r.px(20)),
        children: <Widget>[
          AtCellTitle('基本使用'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtDialog.show(
                context: context,
                padding: EdgeInsets.all(r.px(40)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Dialog可以放置任意内容'),
                    SizedBox(height: r.px(20)),
                    AtSwitch(
                      onPressed: (_) {},
                      actived: true,
                    ),
                    SizedBox(height: r.px(20)),
                    AtButton(
                      onPressed: AtDialog.hide,
                      text: 'hello',
                    ),
                    SizedBox(height: r.px(20)),
                    AtButton(
                      onPressed: AtDialog.hide,
                      text: 'hello',
                    ),
                  ],
                ),
              );
            },
          ),
          AtCellTitle('关闭事件'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtDialog.show(
                context: context,
                height: r.px(100),
                padding: EdgeInsets.all(r.px(20)),
                child: AtLink(
                  text: '点我关闭',
                  onPressed: AtDialog.hide,
                ),
              );
            },
          ),
          AtCellTitle('空白区域点击关闭'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtDialog.show(
                context: context,
                padding: EdgeInsets.all(r.px(20)),
                child: Text('点击空白区域关闭'),
                barrierDismissible: true,
              );
            },
          ),
          AtCellTitle('自定义宽高'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtDialog.show(
                context: context,
                width: r.px(400),
                height: r.px(400),
                padding: EdgeInsets.all(r.px(20)),
                child: Text('自定义宽高'),
                barrierDismissible: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
