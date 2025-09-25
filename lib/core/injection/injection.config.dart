// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/signup_usecase.dart' as _i57;
import '../../features/auth/presentation/cubits/auth_cubit.dart' as _i521;
import '../../features/jobs/data/datasources/job_remote_datasource.dart'
    as _i897;
import '../../features/jobs/data/repositories/job_repository_impl.dart'
    as _i280;
import '../../features/jobs/domain/repositories/job_repository.dart' as _i876;
import '../../features/jobs/domain/usecases/create_job_usecase.dart' as _i529;
import '../../features/jobs/domain/usecases/get_jobs_usecase.dart' as _i653;
import '../../features/jobs/domain/usecases/stream_jobs_usecase.dart' as _i461;
import '../../features/jobs/presentation/cubits/job_form_cubit.dart' as _i1012;
import '../../features/jobs/presentation/cubits/job_list_cubit.dart' as _i666;
import 'modules/supabase_module.dart' as _i388;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final supabaseModule = _$SupabaseModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabaseClient);
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
      () => _i161.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i897.JobRemoteDataSource>(
      () => _i897.JobRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i876.JobRepository>(
      () => _i280.JobRepositoryImpl(gh<_i897.JobRemoteDataSource>()),
    );
    gh.lazySingleton<_i57.SignUpUseCase>(
      () => _i57.SignUpUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i17.GetCurrentUserUseCase>(
      () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i461.StreamJobsUseCase>(
      () => _i461.StreamJobsUseCase(gh<_i876.JobRepository>()),
    );
    gh.lazySingleton<_i529.CreateJobUseCase>(
      () => _i529.CreateJobUseCase(gh<_i876.JobRepository>()),
    );
    gh.lazySingleton<_i653.GetJobsUseCase>(
      () => _i653.GetJobsUseCase(gh<_i876.JobRepository>()),
    );
    gh.factory<_i666.JobListCubit>(
      () => _i666.JobListCubit(
        getJobsUseCase: gh<_i653.GetJobsUseCase>(),
        streamJobsUseCase: gh<_i461.StreamJobsUseCase>(),
      ),
    );
    gh.factory<_i521.AuthCubit>(
      () => _i521.AuthCubit(
        loginUseCase: gh<_i188.LoginUseCase>(),
        signUpUseCase: gh<_i57.SignUpUseCase>(),
        logoutUseCase: gh<_i48.LogoutUseCase>(),
        getCurrentUserUseCase: gh<_i17.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i1012.JobFormCubit>(
      () => _i1012.JobFormCubit(gh<_i529.CreateJobUseCase>()),
    );
    return this;
  }
}

class _$SupabaseModule extends _i388.SupabaseModule {}
