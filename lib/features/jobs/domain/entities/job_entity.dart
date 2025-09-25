import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final int? id;
  final String? postedByUser;
  final String? postedByDisplayName;
  final String title;
  final String description;
  final String location;
  final String employmentType;
  final int? salaryMin;
  final int? salaryMax;
  final String currency;
  final String? status;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const JobEntity({
    this.id,
    this.postedByUser,
    this.postedByDisplayName,
    required this.title,
    required this.description,
    required this.location,
    required this.employmentType,
    this.salaryMin,
    this.salaryMax,
    required this.currency,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id, postedByUser, postedByDisplayName, title, description,
    location, employmentType, salaryMin, salaryMax, currency,
    status, userId, createdAt, updatedAt
  ];
}