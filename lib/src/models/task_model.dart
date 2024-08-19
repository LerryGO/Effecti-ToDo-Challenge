import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@Collection()
@JsonSerializable()
@Name('tasks')
class TaskModel {
  Id? id = Isar.autoIncrement;
  final int? cloudId;
  final String title;
  @JsonKey(name: 'user_id')
  final int? userId;
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @JsonKey(name: 'is_done')
  final bool isDone;

  TaskModel(
      {required this.id,
      required this.title,
      this.userId,
      required this.description,
      required this.createdAt,
      required this.isDone,
      this.cloudId,
      this.dueDate});

  TaskModel copyWith(
      {int? id,
      ValueGetter<int?>? cloudId,
      String? title,
      int? userId,
      String? description,
      DateTime? createdAt,
      ValueGetter<DateTime?>? dueDate,
      bool? isDone}) {
    return TaskModel(
        id: id ?? this.id,
        cloudId: cloudId != null ? cloudId() : this.cloudId,
        title: title ?? this.title,
        userId: userId ?? this.userId,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate != null ? dueDate() : this.dueDate,
        isDone: isDone ?? this.isDone);
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, cloudId: $cloudId, title: $title, userId: $userId, description: $description, createdAt: $createdAt, dueDate: $dueDate, isDone: $isDone)';
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    json['is_done'] = json['is_done'] == 'true' ? true : false;

    return _$TaskModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
