import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: const [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
            SizedBox(width: 8),
            Text('Edwin Johnson', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ChatBubble(
                  text: 'Hi! Is the apartment available next weekend?',
                  isMe: false,
                ),
                ChatBubble(text: 'Yes, it’s available 😊', isMe: true),
                ChatBubble(text: 'Is there a coffee machine?', isMe: false),
              ],
            ),
          ),
          _ChatInput(),
        ],
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image, color: Colors.blue),
            onPressed: () {
              // TODO: pick image
            },
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.blue),
            onPressed: () {
              // TODO: pick file
            },
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Your message',
                filled: true,
                fillColor: const Color(0xFFF1F1F1),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // TODO: send message
              },
            ),
          ),
        ],
      ),
    );
  }
}
