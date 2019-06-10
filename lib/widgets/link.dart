import 'package:flutter/material.dart';

import 'rpx.dart';
import 'colors.dart';

class AtLink extends StatefulWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final String text;
  final Widget addonBefore;
  final Widget addonAfter;
  final VoidCallback onPressed;

  AtLink({
    Key key,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.margin,
    @required this.text,
    this.color = AtColors.primaryColor,
    this.addonBefore,
    this.addonAfter,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _AtLinkState createState() => _AtLinkState();
}

class _AtLinkState extends State<AtLink> {
  bool _active = false;

  @override
  void initState() {
    _active = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    // text
    Widget _inner = Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.fontSize ?? r.px(30),
        fontWeight: widget.fontWeight ?? FontWeight.normal,
        color: widget.color,
      ),
    );

    if (widget.addonBefore != null || widget.addonAfter != null) {
      _inner = Row(
        children: <Widget>[
          if (widget.addonBefore != null) widget.addonBefore,
          _inner,
          if (widget.addonAfter != null) widget.addonAfter,
        ],
      );
    }

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => onActive(),
      onTapUp: (_) => onUnActive(),
      onTapCancel: onUnActive,
      child: Container(
        color: Colors.transparent,
        padding: widget.padding,
        margin: widget.margin,
        child: Opacity(
          opacity: _active ? 0.7 : 1,
          child: _inner,
        ),
      ),
    );
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
