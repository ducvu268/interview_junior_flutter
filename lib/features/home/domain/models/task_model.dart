import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final int? id;
  final String title;
  final String description;
  final int status;
  final String due_date;
  final String? created_at;
  final String? updated_at;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.due_date,
    this.created_at,
    this.updated_at,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    int? status,
    String? due_date,
    String? created_at,
    String? updated_at,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      due_date: due_date ?? this.due_date,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.empty() {
    return TaskModel(
      title: '',
      description: '',
      status: 0,
      due_date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      created_at: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      updated_at: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
  }

  static String convertToDBFormat(String input) {
    try {
      DateTime parsedDate;

      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(input)) {
        parsedDate = DateFormat('yyyy-MM-dd').parseStrict(input);
      } else if (RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$').hasMatch(input)) {
        parsedDate = DateFormat('d/M/yyyy').parseStrict(input);
      } else {
        throw FormatException('Invalid date format: $input');
      }

      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      throw FormatException('Invalid date format: $input');
    }
  }

  static String convertToDisplayFormat(String input) {
    try {
      DateTime parsedDate;

      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(input)) {
        parsedDate = DateFormat('yyyy-MM-dd').parseStrict(input);
      } else if (RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(input)) {
        parsedDate = DateFormat('dd/MM/yyyy').parseStrict(input);
      } else {
        throw FormatException('Invalid date format: $input');
      }
      if (parsedDate.year < 1900) {
        return "01/01/2000";
      }
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return "01/01/2000";
    }
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return other is TaskModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.due_date == due_date &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      status,
      due_date,
      created_at,
      updated_at,
    );
  }
}
