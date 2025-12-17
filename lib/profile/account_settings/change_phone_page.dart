import 'package:flutter/material.dart';
import 'package:prelova/widgets/custom_text_field.dart';

class ChangePhonePage extends StatelessWidget {
  ChangePhonePage({super.key});

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Phone'),
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
              'Masukkan nomor telepon baru untuk mengganti nomor Anda.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'New Phone Number',
              controller: phoneController,
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
