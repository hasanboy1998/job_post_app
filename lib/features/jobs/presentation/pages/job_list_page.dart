import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../cubits/job_list_cubit.dart';
import '../cubits/job_list_state.dart';
import '../widgets/job_card.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<JobListCubit>()..startListening(),
        ),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: isDesktop
                ? null
                : AppBar(
                    title: const Text('My Jobs'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                          context.go('/login');
                        },
                      ),
                    ],
                  ),
            body: isDesktop
                ? _buildDesktopLayout(context)
                : _buildMobileLayout(context),
            floatingActionButton: !isDesktop ? _buildFAB(context) : null,
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(right: BorderSide(color: AppColors.border)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                child: const Text(
                  'Job Board',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Divider(height: 1),
              _buildSidebarItem(
                context,
                icon: Icons.work,
                title: 'My Jobs',
                isSelected: true,
                onTap: () {},
              ),
              _buildSidebarItem(
                context,
                icon: Icons.add,
                title: 'Create Job',
                onTap: () => context.push('/jobs/create'),
              ),
              const Spacer(),
              const Divider(height: 1),
              _buildSidebarItem(
                context,
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  context.read<AuthCubit>().logout();
                  context.go('/login');
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Posted Jobs',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/jobs/create'),
                      icon: const Icon(Icons.add),
                      label: const Text('Create New Job'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ResponsiveWrapper(
                  maxWidth: 900,
                  child: _buildJobsList(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildJobsList(context);
  }

  Widget _buildJobsList(BuildContext context) {
    return BlocBuilder<JobListCubit, JobListState>(
      builder: (context, state) {
        if (state is JobListLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is JobListLoaded) {
          if (state.jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.work_off,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No jobs posted yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(Responsive.isDesktop(context) ? 32 : 16),
            itemCount: state.jobs.length,
            itemBuilder: (context, index) {
              return JobCard(job: state.jobs[index]);
            },
          );
        } else if (state is JobListError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return BlocBuilder<JobListCubit, JobListState>(
      builder: (context, state) {
        if (state is JobListLoaded && state.jobs.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () {
              context.push('/jobs/create');
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add, color: AppColors.white),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildSidebarItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          border: isSelected
              ? Border(left: BorderSide(color: AppColors.primary, width: 3))
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
