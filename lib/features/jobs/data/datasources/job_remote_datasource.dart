import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/usecases/create_job_usecase.dart';
import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  Future<JobModel> createJob(CreateJobParams createJobParams,);

  Future<List<JobModel>> getJobs();

  Stream<List<JobModel>> streamJobs();
}

@LazySingleton(as: JobRemoteDataSource)
class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final SupabaseClient client;

  JobRemoteDataSourceImpl(this.client);

  @override
  Future<JobModel> createJob(CreateJobParams params) async {
    final response = await client.from('jobs').insert({
      'title': params.title,
      'posted_by_user' : client.auth.currentUser!.id,
      'posted_by_display_name': params.companyName,
      'description': params.description,
      'location': params.location,
      'employment_type': params.employmentType,
      'salary_min': params.salaryMin,
      'salary_max': params.salaryMax,
      'currency': params.currency,
      'status': 'open',
      'user_id': client.auth.currentUser!.id,
    }).select().single();

    return JobModel.fromJson(response);
  }

  @override
  Future<List<JobModel>> getJobs() async {
    final response = await client
        .from('jobs')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => JobModel.fromJson(json)).toList();
  }

  @override
  Stream<List<JobModel>> streamJobs() {
    return client
        .from('jobs')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => JobModel.fromJson(json)).toList());
  }
}
