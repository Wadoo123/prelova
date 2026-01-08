import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Dummy model for product
class CheckoutProduct {
  final String name;
  final String imageUrl;
  final int price;
  final int quantity;

  CheckoutProduct({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = 'COD';

  // Dummy data
  final List<CheckoutProduct> _products = [
    CheckoutProduct(
      name: 'Macbook Pro 14-inch M3 (Used)',
      imageUrl: 'https://img.freepik.com/foto-gratis/gradien-warna-abu-abu-buram-mewah-abstrak-digunakan-sebagai-dinding-studio-latar-belakang-untuk-menampilkan-produk-anda_1258-68152.jpg?semt=ais_hybrid&w=740&q=80', // Placeholder image
      price: 15000000,
      quantity: 1,
    ),
    CheckoutProduct(
      name: 'Sony WH-1000XM5 Wireless Headphones',
      imageUrl: 'https://img.freepik.com/foto-gratis/gradien-warna-abu-abu-buram-mewah-abstrak-digunakan-sebagai-dinding-studio-latar-belakang-untuk-menampilkan-produk-anda_1258-68152.jpg?semt=ais_hybrid&w=740&q=80', // Placeholder image
      price: 4500000,
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    int totalItems = _products.fold(0, (sum, item) => sum + item.quantity);
    int totalPrice = _products.fold(0, (sum, item) => sum + (item.price * item.quantity));
    int shippingCost = 15000; // Dummy shipping cost
    int grandTotal = totalPrice + shippingCost;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text('Checkout'),
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 17,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildAddressSection(),
                  const SizedBox(height: 24),
                  _buildProductListSection(),
                  const SizedBox(height: 24),
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 24),
                  _buildOrderSummarySection(totalItems, totalPrice, shippingCost),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomBar(grandTotal),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.grey.shade600,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Shipping Address'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(CupertinoIcons.map_pin_ellipse, color: Colors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe (+62 812-3456-7890)',
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Jl. Jend. Sudirman No. 123, RT 01/RW 02, Kel. Bendungan Hilir, Kec. Tanah Abang, Jakarta Pusat, DKI Jakarta, 10210',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.grey.shade700, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(CupertinoIcons.chevron_forward, color: Color(0xFFC7C7CC), size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Products'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: _products.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(product.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 4),
                          Text('Qty: ${product.quantity}', style: const TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                     Text('Rp${(product.price).toStringAsFixed(0)}', style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Payment Method'),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildPaymentTile(
                methodName: 'COD (Cash On Delivery)',
                icon: CupertinoIcons.money_dollar_circle,
                value: 'COD',
                isLocked: false,
              ),
              _buildPaymentTile(
                methodName: 'GoPay',
                icon: CupertinoIcons.dot_radiowaves_right,
                value: 'GoPay',
                isLocked: true,
              ),
              _buildPaymentTile(
                methodName: 'DANA',
                icon: CupertinoIcons.creditcard,
                value: 'DANA',
                isLocked: true,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentTile({required String methodName, required IconData icon, required String value, bool isLocked = false, bool isLast = false}) {
    bool isSelected = _selectedPaymentMethod == value;
    Color color = isLocked ? Colors.grey.shade400 : Colors.black;

    return GestureDetector(
      onTap: isLocked ? null : () => setState(() => _selectedPaymentMethod = value),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: isLast ? null : Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(child: Text(methodName, style: TextStyle(fontFamily: 'Poppins', color: color, fontSize: 15, fontWeight: FontWeight.w500))),
            if (isLocked)
              const Icon(CupertinoIcons.lock_fill, color: Color(0xFFC7C7CC), size: 20)
            else if (isSelected)
              const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blue, size: 22)
            else
              const Icon(CupertinoIcons.circle, color: Color(0xFFC7C7CC), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummarySection(int totalItems, int totalPrice, int shippingCost) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Shopping Summary'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSummaryRow('Total Price ($totalItems items)', 'Rp${totalPrice.toStringAsFixed(0)}'),
              const SizedBox(height: 12),
              _buildSummaryRow('Shipping Cost', 'Rp${shippingCost.toStringAsFixed(0)}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey.shade700)),
        Text(value, style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildBottomBar(int grandTotal) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, spreadRadius: 5)],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Grand Total', style: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 2),
              Text('Rp${grandTotal.toStringAsFixed(0)}', style: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          CupertinoButton.filled(
            onPressed: () {
              // Payment logic
            },
            child: const Text('Pay Now', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
