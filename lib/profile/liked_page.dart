import 'package:flutter/material.dart';

class LikedPage extends StatelessWidget {
  LikedPage({super.key});

  final List<String> likedProducts = List.generate(
    25,
    (index) => 'Liked Product $index',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Liked'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: likedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[(index % 9 + 1) * 100],
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }
}
