import 'package:equatable/equatable.dart';
import '../../domain/entities/job_entity.dart';

abstract class JobListState extends Equatable {
  const JobListState();

  @override
  List<Object?> get props => [];
}

class JobListInitial extends JobListState {}

class JobListLoading extends JobListState {}

class JobListLoaded extends JobListState {
  final List<JobEntity> jobs;

  const JobListLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class JobListError extends JobListState {
  final String message;

  const JobListError(this.message);

  @override
  List<Object?> get props => [message];
}