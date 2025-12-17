import 'package:flutter/material.dart';

class MyPurchasesPage extends StatelessWidget {
  const MyPurchasesPage({super.key});

  static final List<Map<String, dynamic>> dummyPurchases = [
    {
      'title': 'Belanja',
      'date': '8 Des 2025',
      'status': 'Tiba di Tujuan',
      'productName': 'Windows 11 Pro OEM Original Lifetime',
      'quantity': 1,
      'price': 52750,
      'image': Icons.window,
    },
    {
      'title': 'Belanja',
      'date': '2 Des 2025',
      'status': 'Selesai',
      'productName': 'Microsoft Office 2021 Professional',
      'quantity': 1,
      'price': 125000,
      'image': Icons.apps,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Purchases'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummyPurchases.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = dummyPurchases[index];
          return _PurchaseCard(item: item);
        },
      ),
    );
  }
}

class _PurchaseCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _PurchaseCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(item: item),
            const Divider(height: 20),
            _ProductInfo(item: item),
            const SizedBox(height: 12),
            _Footer(item: item),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Map<String, dynamic> item;

  const _Header({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.shopping_bag_outlined),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              item['date'],
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            item['status'],
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.more_vert),
      ],
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final Map<String, dynamic> item;

  const _ProductInfo({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item['image'], color: Colors.purple),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['productName'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text('${item['quantity']} barang'),
            ],
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final Map<String, dynamic> item;

  const _Footer({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Belanja'),
            Text(
              'Rp ${item['price']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: const Text('Selesai', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
