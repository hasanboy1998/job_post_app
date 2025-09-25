import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

@lazySingleton
class CreateJobUseCase implements UseCase<JobEntity, CreateJobParams> {
  final JobRepository repository;

  CreateJobUseCase(this.repository);

  @override
  Future<Either<Failure, JobEntity>> call(CreateJobParams params) {
    return repository.createJob(params);
  }
}

class CreateJobParams extends Equatable {
  final String title;
  final String companyName;
  final String description;
  final String location;
  final String employmentType;
  final int? salaryMin;
  final int? salaryMax;
  final String currency;

  const CreateJobParams({
    required this.title,
    required this.companyName,
    required this.description,
    required this.location,
    required this.employmentType,
    this.salaryMin,
    this.salaryMax,
    required this.currency,
  });

  @override
  List<Object?> get props => [
    title,
    companyName,
    description,
    location,
    employmentType,
    salaryMin,
    salaryMax,
    currency,
  ];
}
