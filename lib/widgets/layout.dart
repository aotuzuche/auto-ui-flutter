import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'enums.dart';
import 'icon_button.dart';
import 'rpx.dart';
import 'colors.dart';

class AtLayout extends StatelessWidget {
  // 头部widget
  final PreferredSizeWidget header;

  // 身体widget
  final Widget body;

  // 脚widget
  final Widget footer;

  // 背景色
  final Color backgroundColor;

  AtLayout({
    Key key,
    this.header,
    @required this.body,
    this.footer,
    this.backgroundColor = AtColors.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _header;
    Widget _body;

    if (header != null && header is AtLayoutHeader && (header as AtLayoutHeader).positioned) {
      _body = Stack(
        children: <Widget>[
          body,
          Positioned(
            child: header,
          ),
        ],
      );
    } else {
      _header = header;
      _body = body;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _header,
      body: _body,
      bottomNavigationBar: footer,
    );
  }
}

class AtLayoutHeader extends StatefulWidget implements PreferredSizeWidget {
  // 标题，显示于该组件中间的文字
  final String title;

  /// 添加一个widget，用于自定义内容，但权重没有title高
  /// 即：有title属性时，child的设置将会无效
  final Widget child;

  // 位于左侧的widget
  final Widget addonBefore;

  // 位于右侧的widget
  final Widget addonAfter;

  // 位于下方的widget
  final Widget addonBottom;

  // headline模式，即标题较大的一种样式
  final bool headline;

  /// header下方那条边的样式
  /// 可以是 AtBorder.None AtBorder.Shadow AtBorder.Line 的一种
  final AtBorder border;

  // 背景色
  final Color backgroundColor;

  // 返回按钮点击事件，设置该方法后才会显示返回按钮
  final VoidCallback onBackPressed;

  // 关闭按钮点击事件，设置该方法后才会显示关闭按钮
  final VoidCallback onClosePressed;

  // 状态栏颜色
  final Brightness brightness;

  // 用Positioned的方式固定头部
  final bool positioned;

  // 是否可见，切换可见时会以动画的方式切换
  final bool visible;

  /// 透明头，即头部底色为透明，title和按钮为白色的那种
  /// 一般需要和 positioned 属性一起使用
  final bool ghost;

  AtLayoutHeader({
    Key key,
    this.title,
    this.child,
    this.addonBefore,
    this.addonAfter,
    this.addonBottom,
    this.headline = false,
    this.border = AtBorder.Shadow,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.onBackPressed,
    this.onClosePressed,
    this.brightness = Brightness.dark,
    this.positioned = false,
    this.visible = true,
    this.ghost = false,
  })  : assert(child != null || title != null),
        preferredSize = Size.fromHeight(1000),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _AtLayoutHeaderState createState() => _AtLayoutHeaderState();
}

class _AtLayoutHeaderState extends State<AtLayoutHeader> with SingleTickerProviderStateMixin {
  AnimationController aniController;

  @override
  void initState() {
    super.initState();

    aniController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
      value: widget.visible ? 1 : 0,
    );
    aniController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(AtLayoutHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.visible && !widget.visible) {
      aniController.forward();
    } else if (!oldWidget.visible && widget.visible) {
      aniController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    // 底部阴影或线
    List<BoxShadow> _borderShadow = [];
    BoxBorder _border;
    if (widget.border == AtBorder.Shadow) {
      if (widget.ghost) {
        _borderShadow.add(BoxShadow(
          color: Colors.black.withOpacity(0),
          spreadRadius: r.px(30),
          blurRadius: r.px(30),
          offset: Offset(0, 0),
        ));
      } else {
        _borderShadow.add(BoxShadow(
          color: Colors.black.withOpacity(0.07),
          spreadRadius: r.px(30),
          blurRadius: r.px(30),
          offset: Offset(0, r.px(-30)),
        ));
      }
    } else if (widget.border == AtBorder.Line) {
      _border = Border(
        bottom: BorderSide(
          width: r.px(1),
          color: AtColors.borderColor.withOpacity(widget.ghost ? 0 : 1),
        ),
      );
    }

    // 内部
    Widget _inner = SafeArea(
      top: true,
      child: _renderHeaderContent(),
    );

    // 如果有addonBottom
    if (widget.addonBottom != null) {
      _inner = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_inner, widget.addonBottom],
      );
    }

    Widget _result = Opacity(
      opacity: aniController.value,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor.withOpacity(widget.ghost ? 0 : 1),
          border: _border,
          boxShadow: _borderShadow,
        ),
        child: _inner,
      ),
    );

    // 如果不可见，给个空容器
    if (aniController.value == 0) {
      _result = SizedBox(height: 0);
    }

    // 控制状态栏颜色
    _result = AnnotatedRegion<SystemUiOverlayStyle>(
      value: widget.brightness == Brightness.dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: _result,
    );

    return _result;
  }

  // 返回按钮
  Widget _renderBackButton() {
    Rpx r = Rpx.init(context);

    return AtIconButton(
      onPressed: widget.onBackPressed,
      icon: 'lib/widgets/assets/icon-back.png',
      iconColor: widget.ghost ? Colors.white : AtColors.textColor,
      package: 'auto_ui',
      height: r.px(80),
      padding: EdgeInsets.symmetric(horizontal: r.px(20)),
      iconWidth: r.px(30),
      iconHeight: r.px(30),
    );
  }

  // 关闭按钮
  Widget _renderCloseButton() {
    Rpx r = Rpx.init(context);

    return AtIconButton(
      onPressed: widget.onClosePressed,
      icon: 'lib/widgets/assets/icon-close.png',
      iconColor: widget.ghost ? Colors.white : AtColors.textColor,
      package: 'auto_ui',
      height: r.px(80),
      padding: EdgeInsets.symmetric(horizontal: r.px(20)),
      iconWidth: r.px(28),
      iconHeight: r.px(28),
    );
  }

  // 头内容
  Widget _renderHeaderContent() {
    Rpx r = Rpx.init(context);

    Widget _inner = Container();

    bool _hasAddonLR = widget.onBackPressed != null ||
        widget.onClosePressed != null ||
        widget.addonBefore != null ||
        widget.addonAfter != null;

    // 如果有title
    if (widget.title != null) {
      // headline模式
      if (widget.headline) {
        _inner = Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: r.px(_hasAddonLR ? 90 : 40), left: r.px(40)),
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.ghost ? Colors.white : AtColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: r.fpx(48),
            ),
          ),
        );
      } else {
        _inner = Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.ghost ? Colors.white : AtColors.textColor,
              fontSize: r.fpx(36),
            ),
          ),
        );
      }
    } else if (widget.child != null) {
      // title和child只能用其中一项，title权重较高
      _inner = Container(
        width: double.infinity,
        height: double.infinity,
        padding: widget.headline ? EdgeInsets.only(top: r.px(_hasAddonLR ? 90 : 40)) : null,
        child: widget.child,
      );
    }

    // 左侧
    List<Widget> _addonBefore = [];
    if (widget.onBackPressed != null) {
      if (_addonBefore.length == 0) {
        _addonBefore.add(SizedBox(width: r.px(20)));
      }
      _addonBefore.add(_renderBackButton());
    }
    if (widget.onClosePressed != null) {
      if (_addonBefore.length == 0) {
        _addonBefore.add(SizedBox(width: r.px(20)));
      }
      _addonBefore.add(_renderCloseButton());
    }
    if (widget.addonBefore != null) {
      _addonBefore.add(widget.addonBefore);
    }

    // 计算高度
    double _height = 0;
    if (widget.headline) {
      _height = _hasAddonLR ? 240 : 160;
      if (widget.addonBottom != null) {
        _height -= _hasAddonLR ? 80 : 50;
      }
    } else {
      _height = widget.addonBottom != null ? 110 : 100;
    }

    return Container(
      width: double.infinity,
      height: r.px(_height),
      alignment: Alignment.topLeft,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: r.px(widget.headline ? 240 : 110),
            child: _inner,
          ),
          if (_addonBefore.length > 0)
            Positioned(
              left: 0,
              top: 0,
              height: r.px(110),
              child: Row(children: _addonBefore),
            ),
          if (widget.addonAfter != null)
            Positioned(
              top: 0,
              right: 0,
              height: r.px(110),
              child: Row(
                children: [widget.addonAfter],
              ),
            ),
        ],
      ),
    );
  }
}

class AtLayoutBody extends StatelessWidget {
  final List<Widget> children;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool showScrollBar;
  final ScrollController scrollController;
  final bool scrollable;

  const AtLayoutBody({
    Key key,
    this.children,
    this.child,
    this.padding,
    this.scrollController,
    this.showScrollBar = false,
    this.scrollable = true,
  })  : assert(children != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    if (child != null) {
      _children.add(child);
    }
    if (children != null && children.length > 0) {
      _children.addAll(children);
    }

    Widget _child;

    if (scrollable) {
      _child = ListView(
        padding: padding,
        controller: scrollController,
        children: _children,
      );
      if (showScrollBar) {
        _child = Scrollbar(child: _child);
      }
      return Container(
        width: double.infinity,
        child: _child,
      );
    }

    _child = Column(
      children: _children,
    );

    return Container(
      padding: padding,
      width: double.infinity,
      child: _child,
    );
  }
}

class AtLayoutFooter extends StatelessWidget {
  final List<Widget> children;
  final Widget child;
  final AtBorder border;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  AtLayoutFooter({
    Key key,
    this.children,
    this.child,
    this.border = AtBorder.Shadow,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.padding,
  })  : assert(children != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    List<BoxShadow> _borderShadow = [];
    BoxBorder _border;
    EdgeInsetsGeometry _padding = padding;
    List<Widget> _chidren = [];

    // 上边样式
    if (border == AtBorder.Shadow) {
      _borderShadow.add(BoxShadow(
        color: Colors.black.withOpacity(0.02),
        spreadRadius: r.px(20),
        blurRadius: r.px(20),
        offset: Offset(0, r.px(20)),
      ));
    } else if (border == AtBorder.Line) {
      _border = Border(
        top: BorderSide(
          width: r.px(1),
          color: AtColors.borderColor,
        ),
      );
    }

    // 如果child不为空
    if (child != null) {
      _chidren.add(child);
    }

    // 如果children不为空
    if (children != null && children.length > 0) {
      _chidren.addAll(children);
    }

    // 如果padding为空，设置默认padding
    if (_padding == null) {
      _padding = EdgeInsets.symmetric(
        vertical: r.px(20),
        horizontal: r.px(40),
      );
    }

    return Container(
      width: double.infinity,
      padding: _padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: _border,
        boxShadow: _borderShadow,
      ),
      child: SafeArea(
        bottom: true,
        child: _chidren.length > 1 ? Row(children: _chidren) : _chidren[0],
      ),
    );
  }
}
