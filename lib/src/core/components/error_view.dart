import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";

/// Centered error message with a retry button.
///
/// Shows [AppFailure.userMessage] when [error] is an [AppFailure], and a
/// generic message otherwise.
class const ErrorView({
  super.key,
  required final Object error,
  required final VoidCallback onRetry,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String message = switch (error) {
      AppFailure(:final userMessage) => userMessage,
      _ => "Something went wrong.",
    };

    return Center(
      child: Padding(
        padding: const .all(spaceXL),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(message, textAlign: .center),
            const SizedBox(height: spaceXL),
            FilledButton(onPressed: onRetry, child: const Text("Retry")),
          ],
        ),
      ),
    );
  }
}
