import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:job_post_app/features/jobs/domain/entities/job_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_jobs_usecase.dart';
import '../../domain/usecases/stream_jobs_usecase.dart';
import 'job_list_state.dart';

@injectable
class JobListCubit extends Cubit<JobListState> {
  final GetJobsUseCase getJobsUseCase;
  final StreamJobsUseCase streamJobsUseCase;
  StreamSubscription<List<JobEntity>>? _jobsSubscription;

  JobListCubit({required this.getJobsUseCase, required this.streamJobsUseCase})
    : super(JobListInitial());

  Future<void> loadJobs() async {
    emit(JobListLoading());

    final result = await getJobsUseCase(NoParams());

    result.fold(
      (failure) => emit(JobListError(failure.message)),
      (jobs) => emit(JobListLoaded(jobs)),
    );
  }

  void startListening() {
    emit(JobListLoading());

    _jobsSubscription?.cancel();

    _jobsSubscription = streamJobsUseCase(NoParams()).listen(
      (jobs) {
        emit(JobListLoaded(jobs));
      },
      onError: (error) {
        emit(JobListError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _jobsSubscription?.cancel();
    return super.close();
  }
}
