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

class AtRadio extends StatefulWidget {
  final String text;
  final AtTheme theme;
  final bool disabled;
  final bool actived;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Function(bool) onPressed;

  AtRadio({
    Key key,
    this.text = '',
    this.theme = AtTheme.Primary,
    this.disabled = false,
    this.actived = false,
    this.margin,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  _AtRadioState createState() => _AtRadioState();
}

class _AtRadioState extends State<AtRadio> {
  bool _active = false;

  @override
  void initState() {
    _active = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

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

    // radio
    Widget _radio = AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: r.px(32),
      height: r.px(32),
      padding: EdgeInsets.all(r.px(6)),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(r.px(16)),
      ),
      child: widget.actived
          ? Image.asset(
              'lib/widgets/assets/icon-finished.png',
              package: 'auto_ui',
              color: Colors.white,
            )
          : null,
    );

    // 文字
    Widget _text;
    if (widget.text != null && widget.text != '') {
      _text = Text(
        widget.text,
        style: TextStyle(
          color: widget.disabled
              ? AtColors.textColor.withOpacity(0.5)
              : AtColors.textColor.withOpacity(_active || !widget.actived ? 0.7 : 1),
          fontSize: r.px(28),
        ),
      );
    }

    Widget _result = Container(
      color: Colors.transparent,
      margin: widget.margin,
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: r.px(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _radio,
          if (_text != null) SizedBox(width: r.px(12)),
          if (_text != null) _text,
        ],
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
