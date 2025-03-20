import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final String id;
  final String? userName;
  final String? name;
  final String email;
  final String phoneNumber;

  const UserInfoModel({
    required this.id,
    this.userName,
    this.name,
    required this.email,
    required this.phoneNumber,
  });

  UserInfoModel copyWith({
    String? id,
    String? userName,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return UserInfoModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  factory UserInfoModel.empty() {
    return const UserInfoModel(
      id: '',
      userName: '',
      name: '',
      email: '',
      phoneNumber: '',
    );
  }

  @override
  String toString() {
    return 'UserInfoModel(id: $id, userName: $userName, name: $name, email: $email, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return other is UserInfoModel &&
        other.id == id &&
        other.userName == userName &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return Object.hash(id, userName, name, email, phoneNumber);
  }
}
