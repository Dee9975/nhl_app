import "package:flutter/material.dart";

/// Large value over a small label, e.g. `82` over `GP`. Fills an equal share
/// of a [Row].
class const HeadlineStat({
  super.key,
  required final String label,
  required final String value,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(fontWeight: .bold),
          ),
          Text(label, style: textTheme.labelMedium),
        ],
      ),
    );
  }
}
