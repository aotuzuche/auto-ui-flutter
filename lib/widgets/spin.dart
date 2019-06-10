import 'package:flutter/material.dart';

class AtSpin extends StatefulWidget {
  final double size;
  final double borderWidth;
  final Color color;

  AtSpin({
    @required this.size,
    @required this.borderWidth,
    this.color,
  });

  @override
  _AtSpinState createState() => _AtSpinState();
}

class _AtSpinState extends State<AtSpin> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    controller.addListener(() => setState(() {}));
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        size: Size.square(widget.size),
        painter: AtCircle(
          borderWidth: widget.borderWidth,
          skip: controller.value * 100,
          progress: 33,
          color: widget.color,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AtCircle extends CustomPainter {
  Paint p1;
  Paint p2;
  final double borderWidth;
  final double progress;
  final double skip;
  final Color color;

  AtCircle({
    this.borderWidth = 1,
    this.progress = 0,
    this.skip = 0,
    this.color,
  }) {
    p1 = Paint()
      ..color = (this.color ?? Colors.white).withOpacity(0.3)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..isAntiAlias = true;

    p2 = Paint()
      ..color = this.color ?? Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas cvs, Size size) {
    double _v = 3.1415926 / 180;
    Offset _center = Offset(size.width / 2, size.height / 2);
    cvs.drawCircle(_center, size.width / 2 - 4, p1);
    cvs.drawArc(
      Rect.fromCircle(
        center: _center,
        radius: size.width / 2 - 4,
      ),
      3.6 * skip * _v - _v * 90,
      3.6 * progress * _v,
      false,
      p2,
    );
  }

  @override
  bool shouldRepaint(AtCircle o) {
    return o.skip != skip || o.progress != progress;
  }
}
