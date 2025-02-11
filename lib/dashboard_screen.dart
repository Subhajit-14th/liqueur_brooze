import 'package:flutter/material.dart';
import 'package:liqueur_brooze/admin_panel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.orange.shade50,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.orange.shade50,
      drawer: const AdminDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: [
            UserCard(
                name: 'dnnd ndjfn',
                email: 'jdjfj@gmail.com',
                showLoading: false),
            UserCard(name: 'mox shah', email: 'mox@gmail.com'),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final bool showLoading;

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Email: $email',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (showLoading)
            const CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
        ],
      ),
    );
  }
}
