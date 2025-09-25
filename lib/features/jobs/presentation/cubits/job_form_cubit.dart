import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/create_job_usecase.dart';
import 'job_form_state.dart';

@injectable
class JobFormCubit extends Cubit<JobFormState> {
  final CreateJobUseCase createJobUseCase;

  JobFormCubit(this.createJobUseCase) : super(JobFormInitial());

  Future<void> createJob(CreateJobParams params) async {
    emit(JobFormLoading());

    final result = await createJobUseCase(params);

    result.fold(
          (failure) => emit(JobFormError(failure.message)),
          (_) => emit(JobFormSuccess()),
    );
  }

  void reset() {
    emit(JobFormInitial());
  }
}