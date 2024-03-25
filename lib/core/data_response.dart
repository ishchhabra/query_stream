/// Represents a response containing data of type [T].
class DataResponse<T> {
  final bool isFetching;
  final bool isLoading;
  final T? data;
  final String? error;
  final DateTime timestamp;

  /// Creates a [DataResponse] instance.
  const DataResponse({
    required this.isFetching,
    required this.isLoading,
    required this.data,
    required this.error,
    required this.timestamp,
  });

  /// Creates a [DataResponse] instance indicating loading.
  factory DataResponse.loading() => DataResponse(
        isFetching: true,
        isLoading: true,
        data: null,
        error: null,
        timestamp: DateTime.now(),
      );

  /// Creates a [DataResponse] instance indicating fetching.
  ///
  /// Fetching indicates that the data is being refetched. This occurs when the
  /// data is already available from a previous load, and you are requesting
  /// a fresh version of the data.
  factory DataResponse.fetching({required T? data}) => DataResponse(
        isFetching: true,
        isLoading: false,
        data: data,
        error: null,
        timestamp: DateTime.now(),
      );

  /// Creates a [DataResponse] instance with data.
  factory DataResponse.success({required T? data}) => DataResponse(
        isFetching: false,
        isLoading: false,
        data: data,
        error: null,
        timestamp: DateTime.now(),
      );
}
