
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String email;
    UserModel({
    required this.name,
    required this.email
  });


  @override
  String toString() => 'UserModel(name: $name, email: $email)';
  UserModel copyWith({
    String? name,
    String? email    
  }) {
    return UserModel(
          name: name ?? this.name,
      email: email ?? this.email
    );
  }

    factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
