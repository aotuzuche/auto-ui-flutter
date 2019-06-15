import 'package:flutter/material.dart';

import 'divider.dart';
import 'enums.dart';
import 'rpx.dart';
import 'colors.dart';

class AtCell extends StatelessWidget {
  final List<Widget> children;
  final Widget child;
  final double dividerLeftIndent;
  final double dividerRightIndent;
  final AtBorder border;

  AtCell({
    Key key,
    this.child,
    this.children,
    this.dividerLeftIndent = 0,
    this.dividerRightIndent = 0,
    this.border = AtBorder.Line,
  })  : assert(child != null || children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    List<Widget> _children = [];

    // 如果有child，添加child
    if (child != null) {
      _children.add(child);
    }

    // 如果有children，添加children
    if (children != null && children.length > 0) {
      _children.addAll(children);
    }

    // 给所有children添加分割线
    for (int i = 0; i < _children.length; i++) {
      if (i < _children.length - 1) {
        _children.insert(
          ++i,
          AtDivider(
            margin: EdgeInsets.only(
              left: dividerLeftIndent,
              right: dividerRightIndent,
            ),
          ),
        );
      }
    }

    // 外部上下边框
    BoxBorder _border;
    if (border == AtBorder.Line) {
      _border = Border(
        top: BorderSide(
          color: AtColors.borderColor,
          width: r.px(1),
        ),
        bottom: BorderSide(
          color: AtColors.borderColor,
          width: r.px(1),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: _border,
      ),
      child: Column(
        children: _children,
      ),
    );
  }
}

class AtCellRow extends StatefulWidget {
  final bool arrow;
  final List<Widget> children;
  final Widget child;
  final Widget flexStart;
  final Widget flexEnd;
  final String label;
  final EdgeInsetsGeometry padding;
  final dynamic value;
  final Function(dynamic) onPressed;

  AtCellRow({
    Key key,
    this.arrow = false,
    this.children,
    this.child,
    this.flexStart,
    this.flexEnd,
    this.label,
    this.padding,
    this.value,
    this.onPressed,
  })  : assert(label != null || child != null || children != null),
        super(key: key);

  @override
  _AtCellRowState createState() => _AtCellRowState();
}

class _AtCellRowState extends State<AtCellRow> {
  bool _active = false;

  @override
  void initState() {
    super.initState();
    _active = false;
  }

  // 最外层容器
  Widget _renderWrapper(List<Widget> children) {
    Rpx r = Rpx.init(context);

    Widget _result = AnimatedContainer(
      duration: Duration(milliseconds: 100),
      color: _active ? AtColors.borderColor.withOpacity(0.4) : AtColors.borderColor.withOpacity(0),
      constraints: BoxConstraints(
        minHeight: r.px(100),
      ),
      padding: widget.padding ??
          EdgeInsets.symmetric(
            horizontal: r.px(40),
          ),
      child: Row(
        children: children,
      ),
    );

    if (widget.onPressed != null) {
      _result = GestureDetector(
        onTap: () => widget.onPressed(widget.value),
        onTapDown: (_) => onActive(),
        onTapUp: (_) => onUnActive(),
        onTapCancel: onUnActive,
        child: _result,
      );
    }

    return _result;
  }

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    List<Widget> _children = [];

    // 如果有flexStart，首先添加
    if (widget.flexStart != null) {
      _children.add(widget.flexStart);
    }

    // 如果label不为空，添加text组件
    if (widget.label != null) {
      _children.add(Text(
        widget.label,
        style: TextStyle(
          fontSize: r.fpx(30),
          color: AtColors.textColor,
        ),
      ));
    }

    // 如果有child，添加child
    if (widget.child != null) {
      _children.add(widget.child);
    }

    // 如果有children，添加children
    if (widget.children != null && widget.children.length > 0) {
      _children.addAll(widget.children);
    }

    // 如果没有箭头和flexEnd
    if (!widget.arrow && widget.flexEnd == null) {
      return _renderWrapper(_children);
    } else {
      // _addonAfter中添加flexEnd和箭头
      List<Widget> _addonAfter = [];
      if (widget.flexEnd != null) {
        _addonAfter.add(widget.flexEnd);
      }
      if (widget.arrow) {
        _addonAfter.add(Image.asset(
          'lib/widgets/assets/icon-next.png',
          package: 'auto_ui',
          width: r.px(18),
          height: r.px(18),
          color: const Color(0xFFCCCCCC),
        ));
      }

      return _renderWrapper([
        Expanded(
          child: Row(
            children: _children,
          ),
        ),
      ]..addAll(_addonAfter));
    }
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

class AtCellTitle extends StatelessWidget {
  final String title;
  final double marginTop;

  AtCellTitle(
    this.title, {
    Key key,
    this.marginTop = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return Container(
      padding: EdgeInsets.only(
        left: r.px(40),
        right: r.px(40),
        top: r.px(20) + marginTop,
        bottom: r.px(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AtColors.titleColor,
          fontSize: r.fpx(30),
        ),
      ),
    );
  }
}
