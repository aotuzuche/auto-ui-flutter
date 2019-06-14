import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

class PageLink extends StatefulWidget {
  @override
  _PageLinkState createState() => _PageLinkState();
}

class _PageLinkState extends State<PageLink> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Link Widget',
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
                AtLink(
                  onPressed: () {},
                  text: '一个链接',
                  margin: EdgeInsets.only(right: r.px(20)),
                ),
                AtLink(
                  color: AtColors.dangerColor,
                  onPressed: () {},
                  text: '另一个链接',
                  margin: EdgeInsets.only(right: r.px(20)),
                ),
                AtLink(
                  color: AtColors.secondaryColor,
                  onPressed: () {},
                  text: '另一个链接',
                ),
              ],
            ),
          ),
          AtCellTitle('字号和粗体'),
          AtCell(
            child: AtCellRow(
              child: AtLink(
                fontWeight: FontWeight.bold,
                fontSize: r.fpx(40),
                onPressed: () {},
                text: '一个链接',
              ),
            ),
          ),
          AtCellTitle('前后挂载', marginTop: r.px(20)),
          AtCell(
            child: AtCellRow(
              children: <Widget>[
                AtLink(
                  onPressed: () {},
                  text: '首页',
                  addonBefore: Icon(
                    Icons.home,
                    size: r.px(40),
                    color: AtColors.primaryColor,
                  ),
                ),
                SizedBox(width: r.px(30)),
                AtLink(
                  onPressed: () {},
                  text: '一个链接',
                  color: AtColors.secondaryColor,
                  addonAfter: Padding(
                    padding: EdgeInsets.only(left: r.px(10)),
                    child: Icon(
                      Icons.link,
                      size: r.px(40),
                      color: AtColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
