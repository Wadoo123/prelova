import 'package:flutter/material.dart';
import 'package:prelova/widgets/custom_text_field.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hint: 'Current Password',
              controller: currentPasswordController,
              obscure: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hint: 'New Password',
              controller: newPasswordController,
              obscure: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hint: 'Confirm New Password',
              controller: confirmPasswordController,
              obscure: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
