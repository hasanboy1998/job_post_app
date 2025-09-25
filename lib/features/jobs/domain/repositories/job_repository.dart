import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/job_entity.dart';
import '../usecases/create_job_usecase.dart';

abstract class JobRepository {
  Future<Either<Failure, JobEntity>> createJob(CreateJobParams createJobParams);

  Future<Either<Failure, List<JobEntity>>> getJobs();

  Stream<List<JobEntity>> streamJobs();
}
