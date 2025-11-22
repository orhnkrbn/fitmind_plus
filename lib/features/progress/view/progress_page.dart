import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:fitmind_plus_ultra_22/core/styles/styles.dart';

class ProgressPage extends ConsumerWidget {
  const ProgressPage({super.key});

  // Mock weekly weight data (date, kg)
  List<Map<String, dynamic>> _mockData() {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final day = now.subtract(Duration(days: 6 - i));
      // simple mock: base 78 +- small variation
      final weight = 78 + (i % 3 == 0 ? 0.8 : (i % 2 == 0 ? -0.4 : 0.2));
      return {'date': day, 'weight': weight};
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = _mockData();
    final last = data.last;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('İlerleme')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Haftalık Kilo', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.md),

              // Chart
              SizedBox(
                height: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: CustomPaint(
                      painter: _LineChartPainter(
                        data.map((e) => (e['weight'] as double)).toList(),
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Last measurement card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: ListTile(
                  title: Text('Son Ölçüm', style: theme.textTheme.titleMedium),
                  subtitle: Text(
                    DateFormat.yMMMd().add_Hm().format(
                      last['date'] as DateTime,
                    ),
                  ),
                  trailing: Text(
                    '${(last['weight'] as double).toStringAsFixed(1)} kg',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> points;
  _LineChartPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = Colors.grey.withAlpha(31)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const left = 30.0;
    const top = 8.0;
    final w = size.width - left - 8;
    final h = size.height - top - 24;

    // draw horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final y = top + (h / 4) * i;
      canvas.drawLine(Offset(left, y), Offset(left + w, y), paintGrid);
    }

    // compute min/max
    final minVal = points.reduce((a, b) => a < b ? a : b);
    final maxVal = points.reduce((a, b) => a > b ? a : b);
    final range = (maxVal - minVal) == 0 ? 1 : (maxVal - minVal);

    // draw line
    final paintLine = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final dx = left + (w / (points.length - 1)) * i;
      final dy = top + h - ((points[i] - minVal) / range) * h;
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }
    canvas.drawPath(path, paintLine);

    // draw points
    final paintDot = Paint()..color = Colors.blue.shade700;
    for (int i = 0; i < points.length; i++) {
      final dx = left + (w / (points.length - 1)) * i;
      final dy = top + h - ((points[i] - minVal) / range) * h;
      canvas.drawCircle(Offset(dx, dy), 4, paintDot);
    }

    // left axis labels (min/max)
    final tpMin = TextPainter(
      text: TextSpan(
        text: minVal.toStringAsFixed(1),
        style: const TextStyle(color: Colors.black54, fontSize: 10),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tpMin.layout();
    tpMin.paint(canvas, Offset(0, top + h - tpMin.height / 2));

    final tpMax = TextPainter(
      text: TextSpan(
        text: maxVal.toStringAsFixed(1),
        style: const TextStyle(color: Colors.black54, fontSize: 10),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tpMax.layout();
    tpMax.paint(canvas, Offset(0, top - tpMax.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
