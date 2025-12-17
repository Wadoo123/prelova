import 'package:flutter/material.dart';
import 'package:prelova/profile/account_settings/change_email_page.dart';
import 'package:prelova/profile/account_settings/change_password_page.dart';
import 'package:prelova/profile/account_settings/change_phone_page.dart';
import 'package:prelova/profile/account_settings/delete_account_page.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text('Account Setting'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _menuSection(
              context,
              items: [
                _MenuData(
                  Icons.email_outlined,
                  'Change Email',
                  page: ChangeEmailPage(),
                ),
                _MenuData(
                  Icons.phone_outlined,
                  'Change Phone',
                  page: ChangePhonePage(),
                ),
                _MenuData(
                  Icons.lock_outline,
                  'Change Password',
                  page: ChangePasswordPage(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _menuSection(
              context,
              items: [
                _MenuData(
                  Icons.delete_outline,
                  'Delete Account',
                  page: const DeleteAccountPage(),
                  isDanger: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuSection(
    BuildContext context, {
    required List<_MenuData> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              _menuItem(context, item),
              if (index != items.length - 1) _divider(),
            ],
          );
        }),
      ),
    );
  }

  Widget _menuItem(BuildContext context, _MenuData item) {
    final color = item.isDanger ? Colors.red : Colors.black87;

    return ListTile(
      leading: Icon(item.icon, color: color),
      title: Text(
        item.title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (item.page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => item.page!),
          );
        }
      },
    );
  }

  Widget _divider() {
    return const Divider(height: 1, thickness: 0.8);
  }
}

class _MenuData {
  final IconData icon;
  final String title;
  final Widget? page;
  final bool isDanger;

  _MenuData(
    this.icon,
    this.title, {
    this.page,
    this.isDanger = false,
  });
}
