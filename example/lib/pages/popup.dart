import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PagePopup extends StatefulWidget {
  @override
  _PagePopupState createState() => _PagePopupState();
}

class _PagePopupState extends State<PagePopup> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      backgroundColor: Colors.white,
      header: AtLayoutHeader(
        title: 'Popup Widget',
        onBackPressed: () => AtRouter.pop(context),
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
              AtPopup.show(
                context: context,
                padding: EdgeInsets.all(r.px(40)),
                barrierDismissible: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Popup可以放置任意内容'),
                    SizedBox(height: r.px(20)),
                    AtSwitch(
                      onPressed: (_) {},
                      actived: true,
                    ),
                    SizedBox(height: r.px(20)),
                    AtButton(
                      onPressed: AtPopup.hide,
                      text: 'hello',
                    ),
                    SizedBox(height: r.px(20)),
                    AtButton(
                      onPressed: AtPopup.hide,
                      text: 'hello',
                    ),
                  ],
                ),
              );
            },
          ),
          AtCellTitle('自定义高度'),
          AtButton(
            text: '点击查看',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {
              AtPopup.show(
                context: context,
                padding: EdgeInsets.all(r.px(40)),
                height: r.vh(),
                child: Column(
                  children: <Widget>[
                    Text('Popup可以放置任意内容'),
                    AtLink(text: '点我关闭', onPressed: AtPopup.hide),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
