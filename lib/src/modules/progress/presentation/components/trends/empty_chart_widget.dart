import 'package:flutter/material.dart';

class EmptyChartWidget extends StatelessWidget {
  const EmptyChartWidget({super.key, required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No data', style: TextStyle(color: scheme.onSurfaceVariant)),
    );
  }
}
