import 'package:flutter/material.dart';

import 'enums.dart';
import 'rpx.dart';
import 'colors.dart';

// 背景颜色
Map<AtTheme, Color> _bgColors = {
  AtTheme.Danger: AtColors.dangerColor,
  AtTheme.Primary: AtColors.primaryColor,
  AtTheme.Secondary: AtColors.secondaryColor,
  AtTheme.Default: AtColors.dangerColor,
};

class AtSwitch extends StatefulWidget {
  final AtTheme theme;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final List<String> io;
  final bool icon;
  final bool actived;
  final bool disabled;
  final Function(bool) onPressed;

  AtSwitch({
    Key key,
    this.theme = AtTheme.Primary,
    this.margin,
    this.padding,
    this.io = const ['', ''],
    this.icon = false,
    this.actived = false,
    this.disabled = false,
    this.onPressed,
  })  : assert(io.length == 2),
        super(key: key);

  @override
  _AtSwitchState createState() => _AtSwitchState();
}

class _AtSwitchState extends State<AtSwitch> {
  bool _active = false;

  @override
  void initState() {
    _active = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    // 是否有提示文字
    bool _hasio = widget.io[0].trim() != "" && widget.io[1].trim() != "";

    Widget _otext = Positioned(
      left: r.px(15),
      top: r.px((48 - 24 * 1.5) / 2),
      child: AnimatedOpacity(
        opacity: widget.actived ? 1 : 0,
        duration: Duration(milliseconds: 100),
        child: Text(
          widget.io[1],
          style: TextStyle(
            fontSize: r.px(24),
            color: Colors.white,
          ),
        ),
      ),
    );

    Widget _itext = Positioned(
      right: r.px(15),
      top: r.px((48 - 24 * 1.5) / 2),
      child: AnimatedOpacity(
        opacity: widget.actived ? 0 : 1,
        duration: Duration(milliseconds: 100),
        child: Text(
          widget.io[0],
          style: TextStyle(
            fontSize: r.px(24),
            color: Color(0xFFBBBBBB),
          ),
        ),
      ),
    );

    // 球内的icon
    Widget _icon;
    EdgeInsetsGeometry _ballPadding;
    if (widget.icon) {
      _icon = Image.asset(
        widget.actived ? 'lib/widgets/assets/icon-finished.png' : 'lib/widgets/assets/icon-close.png',
        package: 'auto_ui',
        color: widget.actived ? _bgColors[widget.theme] : Color(0xFFCCCCCC),
      );
      _ballPadding = EdgeInsets.all(r.px(widget.actived ? 10 : 12));
    }

    // 内部的白球
    Widget _ball = Positioned(
      left: r.px(4),
      top: r.px(4),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
        width: r.px(40),
        height: r.px(40),
        padding: _ballPadding,
        margin: EdgeInsets.only(left: r.px(widget.actived ? _hasio ? 52 : 42 : 0)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(r.px(20)),
        ),
        child: _icon,
      ),
    );

    // 背景色
    Color _background = Color.lerp(
      AtColors.borderColor.withOpacity(widget.disabled ? 0.7 : 1),
      Colors.black,
      widget.disabled ? 0 : _active ? widget.actived ? 0.05 : 0.02 : 0,
    );

    // 如果激活状态，更换背景色
    if (widget.actived) {
      _background = Color.lerp(
        _bgColors[widget.theme].withOpacity(widget.disabled ? 0.7 : 1),
        Colors.black,
        widget.disabled ? 0 : _active ? 0.05 : 0,
      );
    }

    Widget _result = Container(
      color: Colors.transparent,
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: r.px(10)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: r.px(_hasio ? 100 : 90),
        height: r.px(48),
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.circular(r.px(24)),
        ),
        child: Stack(children: <Widget>[
          _itext,
          _otext,
          _ball,
        ]),
      ),
    );

    // 如果有点击事件
    if (widget.onPressed != null) {
      _result = GestureDetector(
        onTap: () => widget.onPressed(widget.actived),
        onTapDown: (_) => onActive(),
        onTapUp: (_) => onUnActive(),
        onTapCancel: onUnActive,
        child: _result,
      );
    }

    // 如果有margin
    if (widget.margin != null) {
      _result = Container(
        margin: widget.margin,
        child: _result,
      );
    }

    return _result;
  }

  void onActive() {
    setState(() {
      _active = true;
    });
  }

  void onUnActive() {
    setState(() {
      _active = false;
    });
  }
}
