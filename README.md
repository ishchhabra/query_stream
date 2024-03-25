# query_stream

A flutter package for managing and executing queries via streams.

## Getting Started

To use this package, follow these steps:

1. Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  query_stream: ^0.0.1
```

1. Install the package by running

```
flutter pub get
```

1. Import the package in your Dart code:

```dart
import 'package:query_stream/query_stream.dart';
```

# Usage

## Creating a QueryStream

To create a `QueryStream`, provide a query function and query stream options:

```dart
final queryStream = QueryStream<int>(
  queryFn: () => Future.value(42),
  queryStreamOptions: QueryStreamOptions(),
);
```

## Executing Queries

To execute a query, use the `executeQuery` method:

```dart
final result = await queryStream.executeQuery();
```

## Listening to Stream Updates

Subscribe to the `stream` to receive updates:

```dart
queryStream.stream.listen((dataResponse) {
  // Handle data response
});
```

