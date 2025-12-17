import 'package:flutter/material.dart';

class HelpdeskPage extends StatelessWidget {
  const HelpdeskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpdesk'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _HelpdeskItem(
            icon: Icons.help_outline,
            title: 'FAQ',
            subtitle: 'Pertanyaan yang sering diajukan',
          ),
          _HelpdeskItem(
            icon: Icons.menu_book,
            title: 'Panduan Penggunaan',
            subtitle: 'Cara menggunakan aplikasi',
          ),
          _HelpdeskItem(
            icon: Icons.build_outlined,
            title: 'Troubleshooting',
            subtitle: 'Solusi masalah umum',
          ),
          _HelpdeskItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Kebijakan & Privasi',
            subtitle: 'Syarat dan ketentuan aplikasi',
          ),
          _HelpdeskItem(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Informasi versi aplikasi',
          ),
        ],
      ),
    );
  }
}

class _HelpdeskItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HelpdeskItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
