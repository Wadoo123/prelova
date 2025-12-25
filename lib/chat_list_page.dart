import 'package:flutter/material.dart';
import '../widgets/chat_tile.dart';
import 'chat_detail_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ChatTile(
            name: 'Edwin Johnson',
            message: 'Cool! Is there a coffee machine?',
            time: '09:01',
            unread: 2,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatDetailPage(),
                ),
              );
            },
          ),
          ChatTile(
            name: 'Annette Black',
            message: 'I’m arriving tomorrow afternoon.',
            time: '09:15',
            unread: 1,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
