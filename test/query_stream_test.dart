import 'package:flutter_test/flutter_test.dart';
import 'package:query_stream/query_stream.dart';

void main() {
  test("QueryStream initializes with no value until executed", () {
    final QueryStream queryStream = QueryStream(
      queryFn: () {},
      queryStreamOptions: QueryStreamOptions(),
    );

    expect(queryStream.stream.hasValue, false);
  });
}
