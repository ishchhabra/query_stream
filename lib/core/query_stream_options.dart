import 'package:query_stream/core/query_stream.dart';

/// Options for configuring a [QueryStream].
class QueryStreamOptions {
  /// The default duration after which the query is considered stale.
  static const Duration defaultStaleTime = Duration(seconds: 5);

  /// The duration after which the query is considered stale.
  final Duration staleTime;

  /// The default value for [executeOnStale].
  static const bool defaultExecuteOnStale = false;

  /// Indicates whether the query should auto-execute when it becomes stale.
  ///
  /// If set to `true`, the query will automatically execute
  /// when it becomes stale based on [staleTime].
  final bool executeOnStale;

  QueryStreamOptions({
    this.staleTime = defaultStaleTime,
    this.executeOnStale = defaultExecuteOnStale,
  });
}
