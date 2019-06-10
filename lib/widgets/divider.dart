import 'package:flutter/material.dart';

import 'rpx.dart';
import 'colors.dart';

class AtDivider extends StatelessWidget {
  final Axis direction;
  final double width;
  final Color color;
  final EdgeInsetsGeometry margin;

  AtDivider({
    Key key,
    this.direction = Axis.horizontal,
    this.width,
    this.color = AtColors.borderColor,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return Container(
      color: color,
      width: direction == Axis.vertical ? r.px(1) : width != null ? width : null,
      height: direction == Axis.horizontal ? r.px(1) : width != null ? width : null,
      margin: margin,
    );
  }
}
