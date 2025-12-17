import 'package:flutter/material.dart';

class MySellingPage extends StatelessWidget {
  const MySellingPage({super.key});

  static final List<Map<String, dynamic>> dummySelling = [
    {
      'title': 'Pesanan Masuk',
      'date': '11 Des 2025',
      'status': 'Menunggu Diproses',
      'buyerName': 'Andi Saputra',
      'productName': 'Jaket Denim Levi’s',
      'quantity': 1,
      'price': 150000,
      'image': Icons.checkroom,
      'statusColor': Colors.orange,
    },
    {
      'title': 'Pesanan Masuk',
      'date': '10 Des 2025',
      'status': 'Sedang Diproses',
      'buyerName': 'Budi Santoso',
      'productName': 'Sepatu Vans Old Skool',
      'quantity': 1,
      'price': 275000,
      'image': Icons.shopping_bag,
      'statusColor': Colors.blue,
    },
    {
      'title': 'Pesanan Masuk',
      'date': '9 Des 2025',
      'status': 'Sedang Dikirim',
      'buyerName': 'Citra Lestari',
      'productName': 'Rok Plisket Hitam',
      'quantity': 1,
      'price': 90000,
      'image': Icons.checkroom,
      'statusColor': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Selling'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummySelling.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _SellingCard(item: dummySelling[index]);
        },
      ),
    );
  }
}

class _SellingCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _SellingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(item: item),
            const Divider(height: 20),
            _ProductInfo(item: item),
            const SizedBox(height: 8),
            _BuyerInfo(item: item),
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
        const Icon(Icons.storefront_outlined),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(item['date'], style: Theme.of(context).textTheme.bodySmall),
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

class _BuyerInfo extends StatelessWidget {
  final Map<String, dynamic> item;

  const _BuyerInfo({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person_outline, size: 18),
        const SizedBox(width: 6),
        Text(
          'Pembeli: ${item['buyerName']}',
          style: Theme.of(context).textTheme.bodySmall,
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
    final status = item['status'];

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Diterima'),
            Text(
              'Rp ${item['price']}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const Spacer(),
        if (status == 'Menunggu Diproses')
          ElevatedButton(
            onPressed: () {
              // nanti: update status ke "Sedang Diproses"
            },
            child: const Text('Proses'),
          )
        else if (status == 'Sedang Diproses')
          ElevatedButton(
            onPressed: () {
              // nanti: update status ke "Sedang Dikirim"
            },
            child: const Text('Kirim'),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
