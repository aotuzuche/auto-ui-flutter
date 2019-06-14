import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageAlert extends StatefulWidget {
  @override
  _PageAlertState createState() => _PageAlertState();
}

class _PageAlertState extends State<PageAlert> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      backgroundColor: Colors.white,
      header: AtLayoutHeader(
        title: 'Alert Widget',
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
              AtAlert.show(
                context: context,
                title: '提示',
                content: '这是一个弹出框',
              );
            },
          ),
          AtCellTitle('没有title时'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtAlert.show(
                context: context,
                content: '这是一个弹出框',
              );
            },
          ),
          AtCellTitle('content左对齐'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtAlert.show(
                context: context,
                content: '这是一个弹出框',
                contentTextAlign: TextAlign.left,
              );
            },
          ),
          AtCellTitle('定义按钮文字'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtAlert.show(
                context: context,
                content: '这是一个弹出框',
                confirmText: 'Confirm',
                cancelText: 'Cancel',
              );
            },
          ),
          AtCellTitle('定义按钮回调方法'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtAlert.show(
                context: context,
                content: '这是一个弹出框',
                confirmText: 'Confirm',
                cancelText: 'Cancel',
                onCancelPressed: () {
                  AtAlert.show(context: context, content: 'cancel');
                },
                onConfirmPressed: () {
                  AtAlert.show(context: context, content: 'confirm');
                },
              );
            },
          ),
          AtCellTitle('自定义按钮'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtAlert.show(
                context: context,
                content: '这是一个弹出框',
                buttons: <AtButton>[
                  AtButton(
                    text: '按钮A',
                    theme: AtTheme.Secondary,
                    onPressed: AtAlert.hide,
                  ),
                  AtButton(
                    text: '按钮B',
                    theme: AtTheme.Danger,
                    onPressed: AtAlert.hide,
                  ),
                  AtButton(
                    text: '按钮C',
                    onPressed: AtAlert.hide,
                  ),
                ],
              );
            },
          ),
          AtCellTitle('自定义内容'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtAlert.show(
                context: context,
                child: Container(
                  child: Icon(Icons.ac_unit),
                ),
              );
            },
          ),
          AtCellTitle('空白区域点击关闭'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtAlert.show(
                context: context,
                content: '点击空白区域关闭',
                barrierDismissible: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
