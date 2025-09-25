import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/responsive_wrapper.dart';
import '../../domain/usecases/create_job_usecase.dart';
import '../cubits/job_form_cubit.dart';
import '../cubits/job_form_state.dart';

class JobFormPage extends StatefulWidget {
  const JobFormPage({super.key});

  @override
  State<JobFormPage> createState() => _JobFormPageState();
}

class _JobFormPageState extends State<JobFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _salaryMinController = TextEditingController();
  final _salaryMaxController = TextEditingController();
  final _skillController = TextEditingController();

  String _workFormat = 'onsite';
  String _employmentType = 'full_time';
  String _currency = 'USD';
  String _salaryPeriod = 'per_month';

  final List<String> _skills = [];
  final List<Map<String, String>> _languages = [
    {'language': 'English', 'level': 'Native'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
        _skillController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
  }

  void _addLanguage() {
    setState(() {
      _languages.add({'language': '', 'level': 'Basic'});
    });
  }

  void _removeLanguage(int index) {
    if (_languages.length > 1) {
      setState(() {
        _languages.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);


    return BlocProvider(
      create: (context) => getIt<JobFormCubit>(),
      child: BlocListener<JobFormCubit, JobFormState>(
        listener: (context, state) {
          if (state is JobFormSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Job posted successfully!')),
            );
            context.pop();
          } else if (state is JobFormError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: const Text('Create Job Post'),
            centerTitle: true,
            backgroundColor: AppColors.white,
          ),
          body: ResponsiveWrapper(
            maxWidth: 800,
            withPadding: false,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isDesktop ? 40 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Step 1 of 3 - Basic Information',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Job Title *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Senior Software Engineer',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Job title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Company Name *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _companyController,
                      decoration: const InputDecoration(
                        hintText: 'Your company name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Company name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Location *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(hintText: 'City, State'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Location is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Work Format *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Remote'),
                            value: 'remote',
                            groupValue: _workFormat,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _workFormat = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Onsite'),
                            value: 'onsite',
                            groupValue: _workFormat,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _workFormat = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Hybrid'),
                            value: 'hybrid',
                            groupValue: _workFormat,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _workFormat = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Employment Type *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: RadioListTile<String>(
                            title: const Text('Full-time'),
                            value: 'full_time',
                            groupValue: _employmentType,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _employmentType = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: RadioListTile<String>(
                            title: const Text('Part-time'),
                            value: 'part_time',
                            groupValue: _employmentType,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                _employmentType = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Job Description *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText:
                            'Describe the role, responsibilities, and requirements...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Job description is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Required Skills',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _skillController,
                            decoration: const InputDecoration(
                              hintText: 'Add skills',
                            ),
                            onFieldSubmitted: (_) => _addSkill(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: _addSkill,
                          icon: const Icon(
                            Icons.add_circle,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    if (_skills.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _skills.map((skill) {
                          return Chip(
                            label: Text(skill),
                            backgroundColor: AppColors.inputBackground,
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () => _removeSkill(skill),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Languages',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _addLanguage,
                          icon: const Icon(Icons.add, color: AppColors.primary),
                          label: const Text('Add language'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._languages.asMap().entries.map((entry) {
                      final index = entry.key;
                      final lang = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: lang['language'],
                                decoration: const InputDecoration(
                                  hintText: 'Language',
                                ),
                                onChanged: (value) {
                                  _languages[index]['language'] = value;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: lang['level'],
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                    8,
                                    16,
                                    0,
                                    16,
                                  ),
                                  hintText: 'Level',
                                ),
                                items:
                                    ['Basic', 'Intermediate', 'Fluent', 'Native']
                                        .map(
                                          (level) => DropdownMenuItem(
                                            value: level,
                                            child: Text(
                                              level,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _languages[index]['level'] = value!;
                                  });
                                },
                              ),
                            ),
                            if (_languages.length > 1)
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: AppColors.error,
                                ),
                                onPressed: () => _removeLanguage(index),
                              ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 20),

                    const Text(
                      'Salary Range',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _salaryMinController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: 'Min'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _salaryMaxController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: 'Max'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _currency,
                            decoration: const InputDecoration(
                              hintText: 'CUR.',
                              contentPadding: EdgeInsets.fromLTRB(8, 16, 0, 16),
                            ),
                            items: ['USD', 'EUR', 'UZS', 'RUB']
                                .map(
                                  (currency) => DropdownMenuItem(
                                    value: currency,
                                    child: Text(currency),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _currency = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'per_month',
                          groupValue: _salaryPeriod,
                          onChanged: (value) {
                            setState(() {
                              _salaryPeriod = value!;
                            });
                          },
                        ),
                        const Text('Per month'),
                        const SizedBox(width: 20),
                        Radio<String>(
                          value: 'per_hour',
                          groupValue: _salaryPeriod,
                          onChanged: (value) {
                            setState(() {
                              _salaryPeriod = value!;
                            });
                          },
                        ),
                        const Text('Per hour'),
                      ],
                    ),
                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.pop();
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text('Save as Draft'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BlocBuilder<JobFormCubit, JobFormState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state is JobFormLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          final salaryMin =
                                              _salaryMinController.text.isEmpty
                                              ? null
                                              : int.tryParse(
                                                  _salaryMinController.text,
                                                );
                                          final salaryMax =
                                              _salaryMaxController.text.isEmpty
                                              ? null
                                              : int.tryParse(
                                                  _salaryMaxController.text,
                                                );

                                          final fullDescription =
                                              '${_descriptionController.text}${_skills.isNotEmpty ? '\n\nRequired Skills: ${_skills.join(', ')}' : ''}\n\nWork Format: ${_workFormat.replaceAll('_', ' ').toUpperCase()}\n\nLanguages: ${_languages.map((l) => '${l['language']} (${l['level']})').join(', ')}';

                                          context.read<JobFormCubit>().createJob(
                                            CreateJobParams(
                                              title: _titleController.text.trim(),
                                              companyName: _companyController.text
                                                  .trim(),
                                              description: fullDescription,
                                              location: _locationController.text
                                                  .trim(),
                                              employmentType: _employmentType,
                                              salaryMin: salaryMin,
                                              salaryMax: salaryMax,
                                              currency: _currency,
                                            ),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: state is JobFormLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                AppColors.white,
                                              ),
                                        ),
                                      )
                                    : const Text('Next'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
