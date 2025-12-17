import 'package:flutter/material.dart';
import 'package:prelova/widgets/custom_text_field.dart';

class ChangeEmailPage extends StatelessWidget {
  ChangeEmailPage({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Email'),
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
            const Text(
              'Masukkan email baru untuk mengganti email akun Anda.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            CustomTextField(hint: 'New Email', controller: emailController),
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
