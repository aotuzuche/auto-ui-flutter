import 'package:flutter/material.dart';

class AtIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double iconWidth;
  final double iconHeight;
  final Color iconColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final String icon;
  final bool disabled;
  final String package;

  AtIconButton({
    Key key,
    @required this.onPressed,
    this.width,
    this.height,
    this.iconWidth,
    this.iconHeight,
    this.iconColor,
    this.padding,
    this.margin,
    this.package,
    @required this.icon,
    this.disabled = false,
  }) : super(key: key);

  @override
  _AtIconButtonState createState() => _AtIconButtonState();
}

class _AtIconButtonState extends State<AtIconButton> {
  bool _active = false;

  @override
  void initState() {
    _active = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color _color = Color.lerp(
      widget.iconColor,
      Colors.white,
      widget.disabled ? 0 : _active ? 0.4 : 0,
    );
    return GestureDetector(
      onTap: widget.disabled ? null : widget.onPressed,
      onTapDown: (_) => onActive(),
      onTapUp: (_) => onUnActive(),
      onTapCancel: onUnActive,
      child: Container(
        color: Colors.transparent,
        height: widget.height,
        width: widget.width,
        padding: widget.padding,
        child: Image.asset(
          widget.icon,
          package: widget.package,
          width: widget.iconWidth,
          height: widget.iconHeight,
          color: _color,
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
