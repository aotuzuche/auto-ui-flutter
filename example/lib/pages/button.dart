import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageButton extends StatefulWidget {
  @override
  _PageButtonState createState() => _PageButtonState();
}

class _PageButtonState extends State<PageButton> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      backgroundColor: Colors.white,
      header: AtLayoutHeader(
        title: 'Button Widget',
        onBackPressed: () => Navigator.pop(context),
        border: AtBorder.Shadow,
      ),
      body: AtLayoutBody(
        showScrollBar: true,
        padding: EdgeInsets.symmetric(vertical: r.px(20)),
        children: <Widget>[
          AtCellTitle('普通按钮'),
          AtButton(
            text: '按钮',
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '按钮',
            theme: AtTheme.Danger,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '按钮',
            theme: AtTheme.Secondary,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '按钮',
            theme: AtTheme.Default,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtCellTitle('空心按钮'),
          AtButton(
            text: '按钮',
            hollow: true,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '按钮',
            hollow: true,
            theme: AtTheme.Danger,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '按钮',
            hollow: true,
            theme: AtTheme.Secondary,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '按钮',
            hollow: true,
            theme: AtTheme.Default,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtCellTitle('自定义高度和字体大小'),
          Row(
            children: <Widget>[
              AtButton(
                text: '按钮',
                height: r.px(200),
                fontSize: r.px(40),
                margin: EdgeInsets.only(left: r.px(40), right: r.px(20), bottom: r.px(20)),
                onPressed: () {},
              ),
              AtButton(
                text: '按钮',
                height: r.px(70),
                fontSize: r.px(26),
                theme: AtTheme.Danger,
                margin: EdgeInsets.only(right: r.px(40), bottom: r.px(20)),
                onPressed: () {},
              ),
            ],
          ),
          AtCellTitle('Loading'),
          AtButton(
            text: '加载中...',
            loading: true,
            theme: AtTheme.Danger,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '加载中...',
            loading: true,
            hollow: true,
            theme: AtTheme.Danger,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '加载中...',
            loading: true,
            theme: AtTheme.Default,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '加载中...',
            loading: true,
            hollow: true,
            theme: AtTheme.Default,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          Row(
            children: <Widget>[
              AtButton(
                text: '加载中...',
                loading: true,
                height: r.px(70),
                margin: EdgeInsets.only(left: r.px(40), right: r.px(20), bottom: r.px(20)),
                onPressed: () {},
              ),
              AtButton(
                text: '加载中...',
                loading: true,
                hollow: true,
                height: r.px(70),
                margin: EdgeInsets.only(bottom: r.px(20)),
                onPressed: () {},
              ),
            ],
          ),
          AtCellTitle('Disabled'),
          AtButton(
            text: '禁用状态',
            disabled: true,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '禁用状态',
            disabled: true,
            theme: AtTheme.Default,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtButton(
            text: '禁用状态',
            disabled: true,
            theme: AtTheme.Default,
            hollow: true,
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtCellTitle('前后挂载内容'),
          AtButton(
            text: '按钮',
            addonBefore: Container(
              width: r.px(40),
              height: r.px(40),
              color: Colors.teal,
            ),
            addonAfter: Container(
              width: r.px(40),
              height: r.px(40),
              color: Colors.blue,
            ),
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
          AtCellTitle('自定义按钮内容'),
          AtButton(
            child: Icon(Icons.home, color: Colors.white),
            margin: EdgeInsets.only(left: r.px(40), right: r.px(40), bottom: r.px(20)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
