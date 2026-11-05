import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/flutter_svg.dart";

import "package:nhl_app/src/core/core.dart";

/// A team's SVG logo from [url], or a shield icon when there is no URL or
/// it fails to load.
///
/// In the dark theme a `…_light.svg` URL is swapped for its `…_dark.svg`
/// version, so dark logos stay visible on the dark background.
///
/// [size] sets width and height; null fills the parent.
class const TeamLogo({super.key, required final String url, final double? size})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget placeholder = SizedBox(
      width: size,
      height: size,
      child: FittedBox(
        child: Icon(Icons.shield_outlined, color: ref.textSecondary),
      ),
    );
    final String themedUrl = switch (ref.watch(darkThemeProvider)) {
      true => url.replaceFirst(RegExp(r"_light\.svg$"), "_dark.svg"),
      false => url,
    };

    return switch (themedUrl) {
      "" => placeholder,
      _ => SvgPicture.network(
        themedUrl,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => placeholder,
      ),
    };
  }
}
