import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "dio_provider.g.dart";

@Riverpod(keepAlive: true)
Dio dio(Ref ref) => Dio(
  BaseOptions(
    baseUrl: Env.webApiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    headers: {"Accept": "application/json"},
  ),
);
