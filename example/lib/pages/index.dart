import 'package:flutter/material.dart';
import 'package:auto_ui/auto_ui.dart';

import './layout.dart';
import './cell.dart';
import './button.dart';
import './radio.dart';
import './switch.dart';
import './inupt.dart';
import './link.dart';
import './tab_bar.dart';
import './pressed.dart';
import './alert.dart';
import './dialog.dart';
import './popup.dart';
import './toast.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  ScrollController scrollController;
  bool visible;
  double bannerMarginTop;

  @override
  void initState() {
    visible = false;
    bannerMarginTop = 0;

    scrollController = ScrollController();
    scrollController.addListener(() {
      double _ost = scrollController.offset;
      if (!visible && _ost < Rpx.srpx(260)) {
        setState(() {
          visible = true;
        });
      } else if (visible && _ost >= Rpx.srpx(260)) {
        setState(() {
          visible = false;
        });
      }
      if (_ost <= 0) {
        setState(() {
          bannerMarginTop = _ost;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return AtLayout(
      header: AtLayoutHeader(
        title: 'Auto UI',
        border: AtBorder.Shadow,
        positioned: true,
        headline: true,
        brightness: visible ? Brightness.light : Brightness.dark,
        visible: visible,
        addonBottom: Container(
          padding: EdgeInsets.only(left: r.px(40), bottom: r.px(30)),
          child: Text(
            '基本Flutter的一套移动端UI库',
            style: TextStyle(
              color: AtColors.spanColor,
              fontSize: r.fpx(26),
            ),
          ),
        ),
      ),
      body: AtLayoutBody(
        showScrollBar: true,
        padding: EdgeInsets.zero,
        scrollController: scrollController,
        children: <Widget>[
          AtCell(
            dividerIndent: r.px(40),
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, bannerMarginTop),
                child: Container(
                  color: Colors.teal,
                  width: double.infinity,
                  height: r.px(300),
                ),
              ),
              AtCellRow(arrow: true, label: 'Layout', value: 'layout', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Button', value: 'button', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Input', value: 'input', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Cell', value: 'cell', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Link', value: 'link', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Alert', value: 'alert', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Dialog', value: 'dialog', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Popup', value: 'popup', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Radio', value: 'radio', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Switch', value: 'switch', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Toast', value: 'toast', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: '[todo] Loading', value: 'loading', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: '[todo] Spin', value: 'spin', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: '[todo] ActionSheet', value: 'action-sheet', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'TabBar', value: 'tab-bar', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: 'Pressed', value: 'pressed', onPressed: onCellPressed),
              AtCellRow(arrow: true, label: '[todo] TimePicker', value: 'time-picker', onPressed: onCellPressed),
            ],
          ),
        ],
      ),
    );
  }

  // cell点击
  void onCellPressed(p) {
    Map<String, Widget> map = {
      'layout': PageLayout(),
      'cell': PageCell(),
      'button': PageButton(),
      'radio': PageRadio(),
      'switch': PageSwitch(),
      'input': PageInput(),
      'tab-bar': PageTabBar(),
      'pressed': PagePressed(),
      'alert': PageAlert(),
      'dialog': PageDialog(),
      'popup': PagePopup(),
      'link': PageLink(),
      'toast': PageToast(),
    };
    if (map[p] != null) {
      AtRouter.push(context, map[p]);
    }
  }
}
