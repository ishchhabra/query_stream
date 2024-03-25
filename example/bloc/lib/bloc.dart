import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_example/repository.dart';
import 'package:query_stream/query_stream.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class ExampleBloc extends Bloc<ExampleBlocEvent, ExampleBlocState> {
  ExampleRepository _exampleRepository = ExampleRepository();

  ExampleBloc() : super(ExampleBlocInitial()) {
    on<ExampleBlocStarted>(_handleStarted, transformer: restartable());
  }

  Future<void> _handleStarted(
    ExampleBlocStarted event,
    Emitter<ExampleBlocState> emit,
  ) async {
    emit(ExampleBlocLoadInProgress());
    await _exampleRepository.queryStream.executeQuery();
    await emit.forEach(_exampleRepository.queryStream.stream,
        onData: (DataResponse<int> dataResponse) {
      if (dataResponse.isFetching == true) {
        return ExampleBlocLoadInProgress();
      }

      if (dataResponse.data != null) {
        return ExampleBlocLoadSuccess(data: dataResponse.data!);
      }

      return ExampleBlocFailure();
    }, onError: (error, stackTrace) {
      return ExampleBlocFailure();
    });
  }
}
