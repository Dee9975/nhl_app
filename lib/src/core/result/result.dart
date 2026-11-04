import "dart:async";

import "package:dio/dio.dart";
import "package:flutter/services.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "result.freezed.dart";

sealed class Result<T> {
  const Result();

  static Future<Result<T>> guard<T>(Future<T> future) async {
    try {
      return Ok(await future);
    } catch (error, stackTrace) {
      return Err(AppFailure.from(error, stackTrace));
    }
  }

  AsyncValue<T> toAsyncValue() => switch (this) {
    Ok(:final value) => AsyncData(value),
    Err(:final failure) => AsyncError(failure, failure.stackTrace),
  };
}

@freezed
final class const Ok<T>(final T value) extends Result<T> with _$Ok<T>;

@freezed
final class const Err<T>(final AppFailure failure)
    extends Result<T>
    with _$Err<T>;

sealed class AppFailure implements Exception {
  const AppFailure();

  factory from(Object error, StackTrace stackTrace) => switch (error) {
    AppFailure() => error,
    DioException() => _fromDio(error, stackTrace),
    TimeoutException() => TimeoutFailure(stackTrace),
    FormatException() || TypeError() => ParseFailure(error, stackTrace),
    PlatformException(:final code, :final message) => PlatformFailure(
      code,
      message,
      stackTrace,
    ),
    _ => UnknownFailure(error, stackTrace),
  };

  static AppFailure _fromDio(DioException e, StackTrace st) => switch (e.type) {
    .connectionTimeout ||
    .receiveTimeout ||
    .sendTimeout ||
    .transformTimeout => TimeoutFailure(st),
    .connectionError => Offline(st),
    .cancel => Cancelled(st),
    .badResponse => switch (e.response?.statusCode) {
      404 => NotFound(st),
      final code => ServerFailure(
        code,
        e.response?.statusMessage ?? "Request failed",
        st,
      ),
    },
    .badCertificate || .unknown => UnknownFailure(e, st),
  };

  StackTrace get stackTrace;

  String get userMessage => switch (this) {
    Offline() => "No internet connection.",
    TimeoutFailure() => "The server took too long to respond.",
    NotFound() => "We couldn't find that.",
    ServerFailure(:final message) => message,
    Cancelled() ||
    ParseFailure() ||
    PlatformFailure() ||
    UnknownFailure() => "Something went wrong.",
  };
}

@freezed
final class const Offline([@override final StackTrace stackTrace = .empty])
    extends AppFailure
    with _$Offline;

@freezed
final class const TimeoutFailure([
  @override final StackTrace stackTrace = .empty,
]) extends AppFailure with _$TimeoutFailure;

@freezed
final class const Cancelled([@override final StackTrace stackTrace = .empty])
    extends AppFailure
    with _$Cancelled;

@freezed
final class const NotFound([@override final StackTrace stackTrace = .empty])
    extends AppFailure
    with _$NotFound;

@freezed
final class const ServerFailure(
  final int? statusCode,
  final String message, [
  @override final StackTrace stackTrace = .empty,
]) extends AppFailure with _$ServerFailure;

@freezed
final class const ParseFailure(
  final Object error, [
  @override final StackTrace stackTrace = .empty,
]) extends AppFailure with _$ParseFailure;

@freezed
final class const PlatformFailure(
  final String code,
  final String? message, [
  @override final StackTrace stackTrace = .empty,
]) extends AppFailure with _$PlatformFailure;

@freezed
final class const UnknownFailure(
  final Object error, [
  @override final StackTrace stackTrace = .empty,
]) extends AppFailure with _$UnknownFailure;
