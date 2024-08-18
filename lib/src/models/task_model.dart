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
  final String description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final bool isDone;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      this.dueDate,
      required this.isDone,
      this.cloudId});

  TaskModel copyWith(
      {int? id,
      ValueGetter<int?>? cloudId,
      String? title,
      String? description,
      DateTime? createdAt,
      DateTime? dueDate,
      bool? isDone}) {
    return TaskModel(
        id: id ?? this.id,
        cloudId: cloudId != null ? cloudId() : this.cloudId,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate ?? this.dueDate,
        isDone: isDone ?? this.isDone);
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, cloudId: $cloudId, title: $title, description: $description, createdAt: $createdAt, dueDate: $dueDate, isDone: $isDone)';
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
