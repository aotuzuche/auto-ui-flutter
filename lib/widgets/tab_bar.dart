import 'package:flutter/material.dart';

import 'rpx.dart';
import 'colors.dart';
import 'enums.dart';

// 线颜色
Map<AtTheme, Color> _indicatorColors = {
  AtTheme.Danger: AtColors.dangerColor,
  AtTheme.Secondary: AtColors.secondaryColor,
  AtTheme.Primary: AtColors.primaryColor,
  AtTheme.Default: AtColors.primaryColor,
};

class AtTabBar extends StatefulWidget {
  final bool isScrollable;
  final AtTheme theme;
  final TabController controller;
  final List<String> tabs;
  final void Function(int) onPressed;

  const AtTabBar({
    Key key,
    this.isScrollable = false,
    this.onPressed,
    @required this.controller,
    @required this.tabs,
    this.theme = AtTheme.Primary,
  }) : super(key: key);

  @override
  _AtTabBarState createState() => _AtTabBarState();
}

class _AtTabBarState extends State<AtTabBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return TabBar(
      controller: widget.controller,
      labelColor: AtColors.textColor,
      onTap: widget.onPressed,
      unselectedLabelColor: AtColors.smallColor,
      indicatorWeight: r.px(20),
      indicatorColor: _indicatorColors[widget.theme],
      indicator: _AtUnderlineTabIndicator(
        borderSide: BorderSide(
          color: _indicatorColors[widget.theme],
          width: r.px(6),
        ),
        width: r.px(30),
      ),
      isScrollable: widget.isScrollable,
      tabs: widget.tabs.map<Widget>((String name) {
        return Text(
          name,
          style: TextStyle(
            fontSize: r.fpx(30),
            fontWeight: FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }
}

class _AtUnderlineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const _AtUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.width,
    this.insets = EdgeInsets.zero,
  })  : assert(borderSide != null),
        assert(insets != null);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  /// The width of tab's underline.
  final double width;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is _AtUnderlineTabIndicator) {
      return _AtUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is _AtUnderlineTabIndicator) {
      return _AtUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback onChanged]) {
    return _UnderlinePainter(this, width, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, this.width, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final _AtUnderlineTabIndicator decoration;
  final double width;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;
  double get w => width;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    if (w == null) {
      return Rect.fromLTWH(
        indicator.left,
        indicator.bottom - borderSide.width,
        indicator.width,
        borderSide.width,
      );
    }

    return Rect.fromLTWH(
      indicator.left + (indicator.width - w) / 2,
      indicator.bottom - borderSide.width,
      w,
      borderSide.width,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.square;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
