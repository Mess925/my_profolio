import 'dart:math';
import 'package:flutter/material.dart';

class Meteor {
  final double startX;
  final double startY;
  late double endX;
  late double endY;
  final double delay;
  final double duration;

  Meteor(double angle, Size size)
    : startX = Random().nextDouble() * size.width,
      startY = -50,
      delay = Random().nextDouble(),
      duration = 0.3 + Random().nextDouble() * 0.1 {
    endX = startX + cos(angle) * size.width * 0.3;
    endY = size.height + 50;
  }
}

class MeteorPainter extends CustomPainter {
  final Color color;

  MeteorPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trailPaint = Paint()
      ..shader = LinearGradient(
        colors: [color, color.withOpacity(0)],
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), trailPaint);

    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height), 2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MeteorShower extends StatefulWidget {
  final Widget child;
  final int numberOfMeteors;
  final Duration duration;
  final Color meteorColor;

  const MeteorShower({
    super.key,
    required this.child,
    this.numberOfMeteors = 50,
    this.duration = const Duration(seconds: 40),
    required this.meteorColor,
  });

  @override
  _MeteorShowerState createState() => _MeteorShowerState();
}

class _MeteorShowerState extends State<MeteorShower>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Meteor> _meteors = [];
  final double meteorAngle = pi / 4;
  Size? _lastSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeMeteors(Size size) {
    // Only reinitialize if size changed significantly
    if (_lastSize == null ||
        (_lastSize!.width - size.width).abs() > 10 ||
        (_lastSize!.height - size.height).abs() > 10) {
      _meteors = List.generate(
        widget.numberOfMeteors,
        (_) => Meteor(meteorAngle, size),
      );
      _lastSize = size;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Ensure we have valid constraints
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : MediaQuery.of(context).size.height;

        final size = Size(width, height);
        _initializeMeteors(size);

        return ClipRect(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              widget.child,
              ...List.generate(widget.numberOfMeteors, (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final meteor = _meteors[index];
                    final progress =
                        ((_controller.value - meteor.delay) % 1.0) /
                        meteor.duration;
                    if (progress < 0 || progress > 1) {
                      return const SizedBox.shrink();
                    }

                    final left =
                        meteor.startX +
                        (meteor.endX - meteor.startX) * progress;
                    final top =
                        meteor.startY +
                        (meteor.endY - meteor.startY) * progress;

                    // Ensure positioned values are valid
                    if (!left.isFinite || !top.isFinite) {
                      return const SizedBox.shrink();
                    }

                    return Positioned(
                      left: left,
                      top: top,
                      child: Opacity(
                        opacity: (1 - progress) * 0.8,
                        child: Transform.rotate(
                          angle: 315 * (pi / 180),
                          child: CustomPaint(
                            size: const Size(5, 50),
                            painter: MeteorPainter(widget.meteorColor),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
