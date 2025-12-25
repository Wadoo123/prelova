import 'package:flutter/material.dart';
import 'package:prelova/cart_page.dart';
import 'package:prelova/widgets/promo_slider.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: ListView(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'What are you looking for?',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartPage()),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // PROMO SLIDER
          const PromoSlider(),

          const SizedBox(height: 24),

          // ===== TERLARIS =====
          const _SectionTitle(title: '🔥 Product Terlaris'),
          SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 180,
                  child: ProductCard(title: 'Terlaris $index'),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // ===== TERAKHIR DILIHAT =====
          const _SectionTitle(title: '👀 Terakhir Dilihat'),
          SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 180,
                  child: ProductCard(title: 'Terakhir Dilihat $index'),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // ===== REKOMENDASI =====
          const _SectionTitle(title: '✨ Rekomendasi Untuk Kamu'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.61,
              ),
              itemBuilder: (context, index) {
                return ProductCard(title: 'Rekomendasi $index');
              },
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

/// ===== SECTION TITLE (PRIVATE, SIMPLE) =====
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
