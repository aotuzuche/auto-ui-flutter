import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PagePressed extends StatefulWidget {
  @override
  _PagePressedState createState() => _PagePressedState();
}

class _PagePressedState extends State<PagePressed> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Pressed Widget',
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
                AtPressed(
                  onPressed: () {},
                  activeBackgroundColor: Colors.red,
                  activeOpacity: 0.5,
                  child: Text('内容'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
