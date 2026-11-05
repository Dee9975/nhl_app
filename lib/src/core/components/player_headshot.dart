import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";

/// Round player headshot from [url], with a person icon when there is no
/// URL or it fails to load.
class const PlayerHeadshot({
  super.key,
  required final String url,
  final double radius = 20,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ref.surfaceVariant,
      foregroundImage: switch (url) {
        "" => null,
        _ => NetworkImage(url),
      },
      // The person icon below stays visible when the headshot fails.
      onForegroundImageError: switch (url) {
        "" => null,
        _ => (error, stackTrace) {},
      },
      child: Icon(Icons.person, color: ref.textSecondary),
    );
  }
}
