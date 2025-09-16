import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/features/auth/data/repositories/firebase_auth_repositories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthRepositories firebaseAuthRepositories =
        FirebaseAuthRepositories();

    return Scaffold(
      appBar: AppBar(leading: Text("home")),
      body: StreamBuilder<User?>(
        stream: firebaseAuthRepositories.isLogIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Column(
              children: [
                Text('User: ${user.displayName}, ${user.email}'),
                ElevatedButton(
                  onPressed: () {
                    firebaseAuthRepositories.logOut().then((_) {
                      Navigator.pushReplacementNamed(
                        context,
                        ContentsRouter.login,
                      );
                    });
                  },
                  child: const Text("Log out"),
                ),
              ],
            );
          } else {
            // لما يعمل logout هتيجي هنا تلقائي
            return const Text('No user found');
          }
        },
      ),
    );
  }
}
