import 'package:flutter/material.dart';

import 'spin.dart';
import 'enums.dart';
import 'rpx.dart';
import 'colors.dart';

// 按钮颜色
Map<AtTheme, Color> _buttonColors = {
  AtTheme.Danger: AtColors.dangerColor,
  AtTheme.Secondary: AtColors.secondaryColor,
  AtTheme.Primary: AtColors.primaryColor,
  AtTheme.Default: AtColors.borderColor,
};

class AtButton extends StatefulWidget {
  final String text;
  final double width;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Widget addonBefore;
  final Widget addonAfter;
  final AtTheme theme;
  final bool hollow;
  final bool mini;
  final bool loading;
  final bool disabled;
  final VoidCallback onPressed;

  const AtButton({
    Key key,
    this.text,
    this.child,
    this.addonBefore,
    this.addonAfter,
    this.width,
    this.margin,
    this.padding,
    this.theme = AtTheme.Primary,
    this.hollow = false,
    this.mini = false,
    this.loading = false,
    this.disabled = false,
    @required this.onPressed,
  })  : assert(text != null || child != null),
        super(key: key);

  @override
  _AtButtonState createState() => _AtButtonState();
}

class _AtButtonState extends State<AtButton> {
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
    Color _backgroundColor = widget.hollow
        ? Color.lerp(
            Colors.white,
            _buttonColors[widget.theme],
            widget.disabled ? 0 : _active ? 0.05 : 0,
          )
        : Color.lerp(
            _buttonColors[widget.theme].withOpacity(widget.disabled ? 0.7 : 1),
            Colors.black,
            widget.disabled ? 0 : _active ? 0.05 : 0,
          );

    // 边框
    BoxBorder _border = widget.hollow
        ? Border.all(
            color: _buttonColors[widget.theme].withOpacity(widget.disabled ? 0.7 : 1),
            width: r.px(2),
          )
        : null;

    // 文字颜色
    Color _textColor =
        widget.hollow ? _buttonColors[widget.theme].withOpacity(widget.disabled ? 0.7 : 1) : Colors.white;

    // 特殊处理default样式的按钮样式
    if (widget.theme == AtTheme.Default) {
      _textColor = AtColors.smallColor.withOpacity(widget.disabled ? 0.7 : 1);
      if (widget.hollow) {
        _backgroundColor = Color.lerp(
          Colors.white,
          _buttonColors[widget.theme],
          widget.disabled ? 0 : _active ? 0.3 : 0,
        );
      } else {
        _backgroundColor = Color.lerp(
          _buttonColors[widget.theme].withOpacity(widget.disabled ? 0.7 : 1),
          Colors.black,
          widget.disabled ? 0 : _active ? 0.02 : 0,
        );
      }
    }

    // children
    List<Widget> _children = [];

    // loading时
    if (widget.loading) {
      Color _color = Colors.white;
      if (widget.theme == AtTheme.Default) {
        _color = Color.lerp(AtColors.smallColor, Colors.white, 0.5);
      } else if (widget.hollow) {
        _color = Color.lerp(_buttonColors[widget.theme], Colors.white, 0.5);
      }
      _children.add(AtSpin(
        size: r.px(40),
        borderWidth: r.px(3),
        color: _color,
      ));
      _children.add(SizedBox(width: r.px(10)));
    }

    // addonBefore
    if (widget.addonBefore != null) {
      _children.add(widget.addonBefore);
    }

    // 有text时
    if (widget.text != null && widget.text != '') {
      _children.add(Text(
        widget.text,
        style: TextStyle(
          color: _textColor,
          fontSize: r.fpx(30),
        ),
      ));
    }

    // 有child时
    if (widget.child != null) {
      _children.add(widget.child);
    }

    // addonAfter
    if (widget.addonAfter != null) {
      _children.add(widget.addonAfter);
    }

    Widget _result = GestureDetector(
      onTap: widget.disabled ? null : widget.onPressed,
      onTapDown: (_) => onActive(),
      onTapUp: (_) => onUnActive(),
      onTapCancel: onUnActive,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        alignment: Alignment.center,
        width: widget.width ?? null,
        height: r.px(widget.mini ? 72 : 100),
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: r.px(30)),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(r.px(5)),
          border: _border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _children,
        ),
      ),
    );

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
