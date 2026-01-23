import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/core/contents/enum.dart';

import '../service/firestore_model.dart';

class UserModel extends FirestoreModel {
  @override
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int age;
  final GENDER gender;
  final String birthday;
  final DateTime createdAt;
  final String? phone;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.age,
    required this.gender,
    required this.birthday,
    required this.createdAt,
    this.phone,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl ?? "",
      'age': age,
      'gender': gender,
      'phone': phone ?? "",
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['userID'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String?,
      age: map['age'] as int,
      gender: map['gender'] as GENDER,
      birthday: map['birthday'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      phone: map['phone'] as String?,
    );
  }
}

