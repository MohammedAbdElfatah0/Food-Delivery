import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/data/repositories/firebase_auth_repositories.dart';
import 'package:food_delivery/features/auth/domain/entities/user_entity.dart';
import '../../../core/router/contents_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthRepositories firebaseAuthRepositories =
        FirebaseAuthRepositories();

    log(":::::::::::::::::::HOME::::::::::::::::::::::");
    return Scaffold(
      appBar: AppBar(title: const Text('home page'), centerTitle: true),
      body: SafeArea(
        child: FutureBuilder<UserEntity?>(
          future: firebaseAuthRepositories.getCurrentUser(),
          builder: (context, snapshot) {
          // loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

         // failure data
            if (snapshot.hasError) {
              log('Error getting user: ${snapshot.error}');
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 56),
                      const SizedBox(height: 12),
                      const Text(
                        'An error occurred while fetching user data',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Try reloading by rebuilding the widget
                          (context as Element).reassemble();
                        },
                        child: const Text('try again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // If the data returned is null => No user is logged in
            final user = snapshot.data;
            if (user == null) {
              return Center(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'You are not logged in',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              ContentsRouter.auth,
                              (route) => false,
                            );
                          },
                          child: const Text('go login'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // If the data exists
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 36.0,
                  ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 36,
                            child: Icon(Icons.person, size: 40),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Hello, ${user.name.isEmpty ? 'Unknown user' : user.name}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Email: ${user.email.isEmpty ? 'Not available' : user.email}',
                          ),
                          const SizedBox(height: 4),
                          Text('ID: ${user.id}'),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  log("Attempting to sign out...");
                                  await firebaseAuthRepositories.logOut();
                                  log("Sign out completed.");
                                  if (context.mounted) {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      ContentsRouter.auth,
                                      (route) => false,
                                    );
                                  }
                                },
                                icon: const Icon(Icons.logout),
                                label: const Text('Sign out'),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton.icon(
                                onPressed: () {
                                  // Example: You can add navigation to the profile page here
                                  // Navigator.pushNamed(context, ContentsRouter.profile);
                                },
                                icon: const Icon(Icons.person_outline),
                                label: const Text('Profile'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
