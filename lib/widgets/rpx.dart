import 'package:flutter/material.dart';

class Rpx {
  // 字体大小是否跟随系统设置
  final bool _allowFontScaling = false;

  // static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  // static double _pixelRatio;
  // static double _statusBarHeight;
  // static double _bottomBarHeight;

  static double srpx(double w) => w * _screenWidth / 750;

  static double _textScaleFactor;

  Rpx.init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    // _mediaQueryData = mediaQuery;
    // _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    // _statusBarHeight = mediaQuery.padding.top;
    // _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  // static MediaQueryData get mediaQueryData => _mediaQueryData;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  // static double get textScaleFactory => _textScaleFactor;

  ///设备的像素密度
  // static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  // static double get screenWidthDp => _screenWidth;

  ///当前设备高度 dp
  // static double get screenHeightDp => _screenHeight;

  ///当前设备宽度 px
  // static double get screenWidth => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  // static double get screenHeight => _screenHeight * _pixelRatio;

  ///状态栏高度 刘海屏会更高
  // static double get statusBarHeight => _statusBarHeight * _pixelRatio;

  ///底部安全区距离
  // static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  ///实际的dp与设计稿px的比例
  // double get scaleWidth => _screenWidth / instance.width;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  double px(double width) => width * _screenWidth / 750;

  // 设备宽度
  double vw() => _screenWidth;

  // 设备高度
  double vh() => _screenHeight;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为true。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is true.
  double fpx(double fontSize) => _allowFontScaling ? px(fontSize) : px(fontSize) / _textScaleFactor;
}
