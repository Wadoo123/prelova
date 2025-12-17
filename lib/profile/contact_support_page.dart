import 'package:flutter/material.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SupportItem(
            icon: Icons.chat_outlined,
            title: 'Live Chat',
            subtitle: 'Chat langsung dengan customer service',
            onTap: () {},
          ),
          _SupportItem(
            icon: Icons.email_outlined,
            title: 'Email Support',
            subtitle: 'support@aplikasi.com',
            onTap: () {},
          ),
          _SupportItem(
            icon: Icons.phone_outlined,
            title: 'WhatsApp',
            subtitle: '+62 812-xxxx-xxxx',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Jam Operasional',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Senin - Jumat\n09.00 - 17.00 WIB'),
        ],
      ),
    );
  }
}

class _SupportItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
