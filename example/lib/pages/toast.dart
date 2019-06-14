import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageToast extends StatefulWidget {
  @override
  _PageToastState createState() => _PageToastState();
}

class _PageToastState extends State<PageToast> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      backgroundColor: Colors.white,
      header: AtLayoutHeader(
        title: 'Toast Widget',
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
              AtToast.show(
                '这是一个Toast',
                context: context,
              );
            },
          ),
          AtCellTitle('内容较多时'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtToast.show(
                '这是一个Toast，但有很多的内容，这是一个Toast，但有很多的内容，这是一个Toast，但有很多的内容，这是一个Toast，但有很多的内容',
                context: context,
              );
            },
          ),
          AtCellTitle('自定义显示时长'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtToast.show(
                '这是一个10秒的Toast',
                context: context,
                duration: 10000,
              );
            },
          ),
        ],
      ),
    );
  }
}
