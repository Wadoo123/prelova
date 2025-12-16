import 'package:flutter/material.dart';
import 'package:prelova/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // abu-abu pias
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMenuCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: const [
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
        ),
        SizedBox(height: 12),
        Text(
          'Victoria Heard',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('victoria@gmail.com', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    return Column(
      children: [
        _menuSection(
          context,
          items: [
            _MenuData(Icons.person, 'View Profile'),
            _MenuData(
              Icons.edit,
              'Edit Profile',
              page: const EditProfilePage(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _menuSection(
          context,
          items: [
            _MenuData(Icons.favorite_border, 'Liked'),
            _MenuData(Icons.shopping_bag_outlined, 'My Purchases'),
            _MenuData(Icons.receipt_long, 'My Orders'),
          ],
        ),
        const SizedBox(height: 16),
        _menuSection(
          context,
          items: [
            _MenuData(Icons.settings, 'Account Setting'),
            _MenuData(Icons.help_outline, 'Helpdesk'),
            _MenuData(Icons.support_agent, 'Contact Support'),
            _MenuData(Icons.logout, 'Logout', isLogout: true),
          ],
        ),
      ],
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
    return ListTile(
      leading: Icon(
        item.icon,
        color: item.isLogout ? Colors.red : Colors.black87,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: item.isLogout ? Colors.red : Colors.black87,
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
  final bool isLogout;

  _MenuData(this.icon, this.title, {this.page, this.isLogout = false});
}
