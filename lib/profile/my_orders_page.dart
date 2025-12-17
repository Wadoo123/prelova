import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  static final List<Map<String, dynamic>> dummyOrders = [
    {
      'title': 'Belanja',
      'date': '10 Des 2025',
      'status': 'Dalam Perjalanan',
      'productName': 'Windows 11 Pro OEM Original Lifetime',
      'quantity': 1,
      'price': 52750,
      'image': Icons.window,
      'statusColor': Colors.orange,
    },
    {
      'title': 'Belanja',
      'date': '9 Des 2025',
      'status': 'Diproses',
      'productName': 'Microsoft Office 2021 Professional',
      'quantity': 1,
      'price': 125000,
      'image': Icons.apps,
      'statusColor': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummyOrders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _OrderCard(item: dummyOrders[index]);
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _OrderCard({required this.item});

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
            color: item['statusColor'].withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            item['status'],
            style: TextStyle(
              color: item['statusColor'],
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
        OutlinedButton(
          onPressed: () {},
          child: const Text('Lacak Pesanan'),
        ),
      ],
    );
  }
}
