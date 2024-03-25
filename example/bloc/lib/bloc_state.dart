part of 'bloc.dart';

sealed class ExampleBlocState {}

class ExampleBlocInitial extends ExampleBlocState {}

class ExampleBlocLoadInProgress extends ExampleBlocState {}

class ExampleBlocLoadSuccess extends ExampleBlocState {
  int data;

  ExampleBlocLoadSuccess({required this.data});
}

class ExampleBlocFailure extends ExampleBlocState {}
