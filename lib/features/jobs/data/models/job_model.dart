import '../../domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    super.id,
    super.postedByUser,
    super.postedByDisplayName,
    required super.title,
    required super.description,
    required super.location,
    required super.employmentType,
    super.salaryMin,
    super.salaryMax,
    required super.currency,
    super.status,
    super.userId,
    super.createdAt,
    super.updatedAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      postedByUser: json['posted_by_user'],
      postedByDisplayName: json['posted_by_display_name'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      employmentType: json['employment_type'] ?? 'full_time',
      salaryMin: json['salary_min'],
      salaryMax: json['salary_max'],
      currency: json['currency'] ?? 'USD',
      status: json['status'],
      userId: json['user_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'posted_by_display_name': postedByDisplayName,
      'description': description,
      'location': location,
      'employment_type': employmentType,
      'salary_min': salaryMin,
      'salary_max': salaryMax,
      'currency': currency,
      'status': 'open',
    };
  }
}