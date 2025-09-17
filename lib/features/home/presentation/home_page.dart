import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/data/repositories/firebase_auth_repositories.dart';
import 'package:food_delivery/features/auth/domain/entities/user_entity.dart'; // افترضت إن UserEntity هنا

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthRepositories firebaseAuthRepositories =
        FirebaseAuthRepositories();
    log(":::::::::::::::::::HOME::::::::::::::::::::::");
    return Scaffold(
      appBar: AppBar(leading: const Text("Home")),
      body: FutureBuilder<UserEntity?>(
        future:
            firebaseAuthRepositories.getCurrentUser(), // جلب بيانات المستخدم
        builder: (context, snapshot) {
          // لو البيانات لسه بتتحمل
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // لو فيه خطأ
          if (snapshot.hasError) {
            return const Center(child: Text('خطأ في جلب بيانات المستخدم'));
          }
          // لو مفيش مستخدم مسجل دخول
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('ما فيش مستخدم مسجل دخول'));
          }
          // لو البيانات جت بنجاح
          final user = snapshot.data!;
          return Column(
            children: [
              Text('مرحبا، ${user.name.isEmpty ? 'مستخدم مجهول' : user.name}'),
              Text('الإيميل: ${user.email.isEmpty ? 'غير متوفر' : user.email}'),
              Text('ID: ${user.id}'),
              ElevatedButton(
                onPressed: () async {
                  await firebaseAuthRepositories.logOut();
                },
                child: Text("signOut"),
              ),
            ],
          );
        },
      ),
    );
  }
}
