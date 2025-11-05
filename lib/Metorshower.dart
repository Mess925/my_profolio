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
      duration = 1.0 + Random().nextDouble() * 2.0 {
    endX = startX + cos(angle) * size.width * 0.3; // Less horizontal movement
    endY = size.height + 50; // Go all the way to bottom + extra
  }
}

class MeteorDemo extends StatelessWidget {
  const MeteorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        MeteorShower(
          numberOfMeteors: 10,
          duration: const Duration(seconds: 5),
          meteorColor: theme.primaryColor,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 96, 96, 96),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Meteor shower',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          theme.primaryColor,
                          theme.primaryColor.withOpacity(0.2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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

    canvas.drawCircle(
      Offset(size.width / 2, size.height),
      2,
      circlePaint,
    ); // Bigger circle
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
    this.numberOfMeteors = 10,
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initializeMeteors(size);

        return Stack(
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
                  if (progress < 0 || progress > 1)
                    return const SizedBox.shrink();

                  return Positioned(
                    left:
                        meteor.startX +
                        (meteor.endX - meteor.startX) * progress,
                    top:
                        meteor.startY +
                        (meteor.endY - meteor.startY) * progress,
                    child: Opacity(
                      opacity: (1 - progress) * 0.8,
                      child: Transform.rotate(
                        angle: 315 * (pi / 180),
                        child: CustomPaint(
                          size: const Size(5, 50), // Bigger meteors
                          painter: MeteorPainter(widget.meteorColor),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  void _initializeMeteors(Size size) {
    // Remove the if check so meteors recalculate on size changes
    _meteors = List.generate(
      widget.numberOfMeteors,
      (_) => Meteor(meteorAngle, size),
    );
  }
}
