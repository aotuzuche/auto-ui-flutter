// pressed容器
import 'package:flutter/material.dart';

class AtPressed extends StatefulWidget {
  final Color activeBackgroundColor;
  final double activeOpacity;
  final Widget child;
  final VoidCallback onPressed;

  AtPressed({
    this.activeBackgroundColor,
    this.activeOpacity,
    @required this.onPressed,
    @required this.child,
  });

  @override
  _AtPressedState createState() => _AtPressedState();
}

class _AtPressedState extends State<AtPressed> {
  bool active = false;

  @override
  void initState() {
    super.initState();
    active = false;
  }

  void on() {
    this.setState(() {
      active = true;
    });
  }

  void off() {
    this.setState(() {
      active = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _child = widget.child;

    if (widget.activeOpacity != null) {
      _child = AnimatedOpacity(
        duration: Duration(milliseconds: 100),
        opacity: active ? widget.activeOpacity : 1,
        child: _child,
      );
    }

    if (widget.activeBackgroundColor != null) {
      _child = AnimatedContainer(
        duration: Duration(milliseconds: 100),
        color: active ? widget.activeBackgroundColor : Colors.transparent,
        child: _child,
      );
    }

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        on();
      },
      onTapUp: (_) {
        off();
      },
      onTapCancel: off,
      child: _child,
    );
  }
}
