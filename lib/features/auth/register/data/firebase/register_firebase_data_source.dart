import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';

class FirebaseRegisterDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<RegisterEntity> register({
    required String name,
    required String email,
    required String password,
    required DateTime birthday,
    required String gender,
    required int age,
  }) async {
    UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = cred.user;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();

      // Store additional data in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'userID':user.uid,
        'name': name,
        'email': email,
        'birthday': birthday.toIso8601String(),
        'gender': gender,
        'age': age,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return RegisterEntity(id: user.uid, name: name, email: email, birthday: birthday, gender: gender, age: age);
    }
    throw Exception('Registration failed');
  }
}