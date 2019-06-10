import 'package:flutter/material.dart';

import 'rpx.dart';
import 'colors.dart';
import 'enums.dart';

class AtInput extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final Widget addonBefore;
  final Widget addonAfter;
  final String value;
  final String placeholder;
  final AtBorder border;
  final Color color;
  final Color placeholderColor;
  final void Function(String) onSaved;

  AtInput({
    Key key,
    this.margin,
    this.addonBefore,
    this.addonAfter,
    this.value,
    this.placeholder,
    this.border = AtBorder.Line,
    this.color = AtColors.textColor,
    this.placeholderColor = AtColors.smallColor,
    this.onSaved,
  }) : super(key: key);

  @override
  _AtInputState createState() => _AtInputState();
}

class _AtInputState extends State<AtInput> {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    Border _border;
    if (widget.border == AtBorder.Line) {
      _border = Border.all(
        width: r.px(2),
        color: AtColors.borderColor,
      );
    }

    Widget _input;
    InputDecoration _decoration = InputDecoration(
      border: InputBorder.none,
      hintText: widget.placeholder,
      hintStyle: TextStyle(
        color: widget.placeholderColor,
        fontSize: r.fpx(30),
      ),
    );

    if (widget.onSaved != null) {
      _input = TextFormField(
        style: TextStyle(
          color: widget.color,
          fontSize: r.fpx(30),
        ),
        textInputAction: TextInputAction.done,
        // scrollPadding: EdgeInsets.zero,
        cursorColor: AtColors.textColor,
        cursorRadius: Radius.circular(0),
        decoration: _decoration,
        onSaved: widget.onSaved,
      );
    } else {
      _input = TextField(
        style: TextStyle(
          color: widget.color,
          fontSize: r.fpx(30),
        ),
        textInputAction: TextInputAction.done,
        // scrollPadding: EdgeInsets.zero,
        cursorColor: AtColors.textColor,
        cursorRadius: Radius.circular(0),
        decoration: _decoration,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: _border,
        color: _border != null ? Colors.white : null,
        borderRadius: _border != null ? BorderRadius.circular(r.px(5)) : null,
      ),
      alignment: Alignment.centerLeft,
      height: r.px(100),
      padding: EdgeInsets.symmetric(
        horizontal: r.px(20),
      ),
      margin: widget.margin,
      child: _input,
    );
  }
}
