import 'package:flutter/material.dart';

class ViewProfilePage extends StatelessWidget {
  ViewProfilePage({super.key});

  final List<String> dummyProducts = List.generate(
    30,
    (index) => 'Product $index',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Nizar Hadabi Erawan'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _ProfileHeader()),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[(index % 9 + 1) * 100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }, childCount: dummyProducts.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            child: Text('A', style: TextStyle(fontSize: 32)),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nizar Hadabi Erawan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _InfoItem(title: 'Product', value: '0'),
              _InfoItem(title: 'Followers', value: '0'),
              _InfoItem(title: 'Following', value: '0'),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 16),
              SizedBox(width: 4),
              Text('7.9/10 (100)'),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'My name is Nizar Hadabi Erawan, live in Wado, '
            'My hobby is Coding (maybe) dll',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Upload Product'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(title),
      ],
    );
  }
}
