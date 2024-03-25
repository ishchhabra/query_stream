import 'dart:async';

import 'package:query_stream/core/data_response.dart';
import 'package:query_stream/core/query_stream_options.dart';
import 'package:rxdart/rxdart.dart';

typedef QueryFn<ResponseType> = FutureOr<ResponseType> Function();

class QueryStream<T> {
  /// Options for the [QueryStream].
  final QueryStreamOptions queryStreamOptions;

  /// The function that executes the query.
  final QueryFn<T> queryFn;

  final BehaviorSubject<DataResponse<T>> _streamController = BehaviorSubject();

  Timer? _autoExecuteTimer;

  QueryStream({required this.queryFn, required this.queryStreamOptions}) {
    _initAutoExecute();
  }

  /// The stream of [DataResponse] containing the query result and status.
  ///
  /// Subscribing to this stream allows listening for updates to the query result.
  /// The stream emits [DataResponse] objects which contain the result data
  /// or an error status when an error occurs during query execution.
  ValueStream<DataResponse<T>> get stream => _streamController.stream;

  /// Checks if the query is stale based on [staleTime].
  bool get isStale {
    if (!_streamController.hasValue) {
      return true;
    }

    final DateTime now = DateTime.now();
    final Duration difference =
        now.difference(_streamController.value.timestamp);

    return difference > queryStreamOptions.staleTime;
  }

  /// Executes the query, optionally forcing a fetch regardless of stateless.
  ///
  /// If [force] is `false` and the data is not stale, returns the current data.
  /// Otherwise, sends a loading state, executes the query, and updates the stream.
  Future<T?> executeQuery({force = false}) async {
    if (!force && !this.isStale) {
      return _streamController.value.data;
    }

    final DataResponse<T> loadingDataResponse = _streamController.hasValue
        ? DataResponse.fetching(data: _streamController.value.data)
        : DataResponse.loading();
    _streamController.sink.add(loadingDataResponse);

    try {
      final T data = await queryFn();
      final DataResponse<T> successDataResponse =
          DataResponse.success(data: data);
      _streamController.sink.add(successDataResponse);
      return data;
    } catch (e, stackTrace) {
      _streamController.addError(e, stackTrace);
      return null;
    }
  }

  void _initAutoExecute() {
    if (this.queryStreamOptions.executeOnStale) {
      this._streamController.onListen = () {
        _autoExecuteTimer = Timer.periodic(
            this.queryStreamOptions.staleTime, (timer) => executeQuery());
      };

      this._streamController.onCancel = () {
        _autoExecuteTimer?.cancel();
      };
    }
  }
}
