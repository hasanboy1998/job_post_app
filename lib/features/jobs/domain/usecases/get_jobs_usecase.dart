import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

@lazySingleton
class GetJobsUseCase implements UseCase<List<JobEntity>, NoParams> {
  final JobRepository repository;

  GetJobsUseCase(this.repository);

  @override
  Future<Either<Failure, List<JobEntity>>> call(NoParams params) {
    return repository.getJobs();
  }
}