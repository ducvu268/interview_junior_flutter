// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  status: (json['status'] as num).toInt(),
  due_date: json['due_date'] as String,
  created_at: json['created_at'] as String?,
  updated_at: json['updated_at'] as String?,
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'status': instance.status,
  'due_date': instance.due_date,
  'created_at': instance.created_at,
  'updated_at': instance.updated_at,
};
