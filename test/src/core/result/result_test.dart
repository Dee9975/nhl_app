import "dart:async";

import "package:dio/dio.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";

DioException _dio(
  DioExceptionType type, {
  int? statusCode,
  String? statusMessage,
}) {
  final RequestOptions options = RequestOptions(path: "/test");
  return DioException(
    requestOptions: options,
    type: type,
    response: switch (statusCode) {
      null => null,
      _ => Response<Object?>(
        requestOptions: options,
        statusCode: statusCode,
        statusMessage: statusMessage,
      ),
    },
  );
}

void main() {
  final StackTrace stackTrace = StackTrace.current;

  group("AppFailure.from", () {
    test("maps every Dio timeout to TimeoutFailure", () {
      for (final DioExceptionType type in [
        DioExceptionType.connectionTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.transformTimeout,
      ]) {
        expect(
          AppFailure.from(_dio(type), stackTrace),
          isA<TimeoutFailure>(),
          reason: "$type",
        );
      }
    });

    test("maps a Dio connection error to Offline", () {
      expect(
        AppFailure.from(_dio(.connectionError), stackTrace),
        isA<Offline>(),
      );
    });

    test("maps a cancelled Dio request to Cancelled", () {
      expect(AppFailure.from(_dio(.cancel), stackTrace), isA<Cancelled>());
    });

    test("maps a 404 to NotFound", () {
      expect(
        AppFailure.from(_dio(.badResponse, statusCode: 404), stackTrace),
        isA<NotFound>(),
      );
    });

    test("maps another bad status to ServerFailure with code and message", () {
      final AppFailure failure = AppFailure.from(
        _dio(.badResponse, statusCode: 503, statusMessage: "Unavailable"),
        stackTrace,
      );

      expect(
        failure,
        isA<ServerFailure>()
            .having((f) => f.statusCode, "statusCode", 503)
            .having((f) => f.message, "message", "Unavailable"),
      );
    });

    test("falls back to a generic message when the status has none", () {
      final AppFailure failure = AppFailure.from(
        _dio(.badResponse, statusCode: 500),
        stackTrace,
      );

      expect(
        failure,
        isA<ServerFailure>().having(
          (f) => f.message,
          "message",
          "Request failed",
        ),
      );
    });

    test("maps a bad certificate and unknown Dio errors to UnknownFailure", () {
      expect(
        AppFailure.from(_dio(.badCertificate), stackTrace),
        isA<UnknownFailure>(),
      );
      expect(
        AppFailure.from(_dio(.unknown), stackTrace),
        isA<UnknownFailure>(),
      );
    });

    test("maps a TimeoutException to TimeoutFailure", () {
      expect(
        AppFailure.from(TimeoutException("slow"), stackTrace),
        isA<TimeoutFailure>(),
      );
    });

    test("maps FormatException and TypeError to ParseFailure", () {
      expect(
        AppFailure.from(const FormatException("bad"), stackTrace),
        isA<ParseFailure>(),
      );
      expect(AppFailure.from(TypeError(), stackTrace), isA<ParseFailure>());
    });

    test("maps a PlatformException to PlatformFailure", () {
      expect(
        AppFailure.from(
          PlatformException(code: "io", message: "disk full"),
          stackTrace,
        ),
        isA<PlatformFailure>()
            .having((f) => f.code, "code", "io")
            .having((f) => f.message, "message", "disk full"),
      );
    });

    test("passes an AppFailure through unchanged", () {
      const AppFailure original = NotFound();

      expect(AppFailure.from(original, stackTrace), same(original));
    });

    test("maps anything else to UnknownFailure", () {
      expect(
        AppFailure.from(StateError("?"), stackTrace),
        isA<UnknownFailure>(),
      );
    });

    test("keeps the stack trace", () {
      expect(AppFailure.from(_dio(.cancel), stackTrace).stackTrace, stackTrace);
    });
  });

  group("AppFailure.userMessage", () {
    test("explains connection problems", () {
      expect(const Offline().userMessage, "No internet connection.");
      expect(
        const TimeoutFailure().userMessage,
        "The server took too long to respond.",
      );
      expect(const NotFound().userMessage, "We couldn't find that.");
    });

    test("shows the server's own message", () {
      expect(
        const ServerFailure(500, "Maintenance").userMessage,
        "Maintenance",
      );
    });

    test("is generic for failures the user can't act on", () {
      for (final AppFailure failure in [
        const Cancelled(),
        const ParseFailure("x"),
        const PlatformFailure("io", null),
        const UnknownFailure("x"),
      ]) {
        expect(
          failure.userMessage,
          "Something went wrong.",
          reason: "$failure",
        );
      }
    });
  });

  group("Result.guard", () {
    test("wraps a value in Ok", () async {
      expect(await Result.guard(Future.value(42)), const Ok(42));
    });

    test("wraps a thrown error in Err with the mapped failure", () async {
      final Result<int> result = await Result.guard(
        Future<int>.error(const FormatException("bad")),
      );

      expect(
        result,
        isA<Err<int>>().having(
          (err) => err.failure,
          "failure",
          isA<ParseFailure>(),
        ),
      );
    });
  });

  group("Result.toAsyncValue", () {
    test("turns Ok into AsyncData", () {
      expect(const Ok(1).toAsyncValue(), const AsyncData(1));
    });

    test("turns Err into AsyncError carrying the failure", () {
      const AppFailure failure = NotFound();

      expect(
        const Err<int>(failure).toAsyncValue(),
        isA<AsyncError<int>>().having((e) => e.error, "error", failure),
      );
    });
  });
}
