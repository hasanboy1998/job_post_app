import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

@lazySingleton
class StreamJobsUseCase implements StreamUseCase<List<JobEntity>, NoParams> {
  final JobRepository repository;

  StreamJobsUseCase(this.repository);

  @override
  Stream<List<JobEntity>> call(NoParams params) {
    return repository.streamJobs();
  }
}