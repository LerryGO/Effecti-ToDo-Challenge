// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final bool isDone;

  TaskModel(
      { this.id,
      this.cloudId,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.isDone});

  TaskModel copyWith(
      {int? id,
      int? cloudId,
      String? title,
      String? description,
      DateTime? createdAt,
      bool? isDone}) {
    return TaskModel(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        isDone: isDone ?? this.isDone);
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, cloudId: $cloudId, title: $title, description: $description, createdAt: $createdAt, isDone: $isDone)';
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
