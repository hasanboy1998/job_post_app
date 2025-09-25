import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:job_post_app/features/jobs/domain/usecases/create_job_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_datasource.dart';

@LazySingleton(as: JobRepository)
class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource;

  JobRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, JobEntity>> createJob(
    CreateJobParams createJobParams,
  ) async {
    try {
      final job = await remoteDataSource.createJob(createJobParams);
      return Right(job);
    } catch (e, s) {
      LoggerService.error(
        'ServerFailure: ${e.toString()}',
        error: e,
        context: this,
        stackTrace: s,
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getJobs() async {
    try {
      final jobs = await remoteDataSource.getJobs();
      return Right(jobs);
    } catch (e, s) {
      LoggerService.error(
        'ServerFailure: ${e.toString()}',
        error: e,
        context: this,
        stackTrace: s,
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<JobEntity>> streamJobs() {
    return remoteDataSource.streamJobs();
  }
}
