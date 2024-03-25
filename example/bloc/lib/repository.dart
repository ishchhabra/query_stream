import 'package:query_stream/query_stream.dart';

class ExampleRepository {
  ExampleRepository();

  final QueryStream<int> queryStream = QueryStream(
    queryFn: () => Future.value(0),
    queryStreamOptions: QueryStreamOptions(),
  );
}
