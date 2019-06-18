import 'package:flutter/material.dart';

class AtIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Alignment alignment;
  final double iconWidth;
  final double iconHeight;
  final Color color;
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
    this.color,
    this.padding,
    this.alignment,
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
        margin: widget.margin,
        child: Align(
          alignment: widget.alignment ?? Alignment.center,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: _active ? 0.6 : 1,
            child: Image.asset(
              widget.icon,
              package: widget.package,
              width: widget.iconWidth,
              height: widget.iconHeight,
              color: widget.color,
            ),
          ),
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
