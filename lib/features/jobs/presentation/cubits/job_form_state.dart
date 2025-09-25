import 'package:equatable/equatable.dart';

abstract class JobFormState extends Equatable {
  const JobFormState();

  @override
  List<Object?> get props => [];
}

class JobFormInitial extends JobFormState {}

class JobFormLoading extends JobFormState {}

class JobFormSuccess extends JobFormState {}

class JobFormError extends JobFormState {
  final String message;

  const JobFormError(this.message);

  @override
  List<Object?> get props => [message];
}