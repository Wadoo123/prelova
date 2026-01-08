import 'package:flutter/material.dart';
import 'package:prelova/widgets/product_card.dart';
import 'package:prelova/models/product.dart';

class ViewProfileSellerPage extends StatefulWidget {
  const ViewProfileSellerPage({super.key});

  @override
  State<ViewProfileSellerPage> createState() => _ViewProfileSellerPageState();
}

class _ViewProfileSellerPageState extends State<ViewProfileSellerPage> with TickerProviderStateMixin {
  // Dummy data for products
  final List<Product> _products = List.generate(
    10,
        (index) => Product(
      name: 'Product $index',
      price: (index + 1) * 100000,
      rating: 4.5,
      sold: (index + 1) * 10,
    ),
  );

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text(
              'Nizar Hadabi Erawan',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            pinned: true,
            floating: false,
            forceElevated: true,
          ),
          SliverToBoxAdapter(
            child: _buildProfileHeader(),
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Product'),
                  Tab(text: 'Likes'),
                  Tab(text: 'Review'),
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                labelStyle: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.normal),
              ),
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductGrid(),
                const Center(child: Text('Likes Tab Content')),
                const Center(child: Text('Reviews Tab Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://www.figma.com/api/mcp/asset/4e097ac1-6585-446b-93bd-dd9408b37ba5'),
                // Placeholder image
                child: Text('A',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nizar Hadabi Erawan',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatColumn('0', 'Product'),
                        _buildStatColumn('0', 'Followers'),
                        _buildStatColumn('0', 'Following'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'My name is Nizar Hadabi Erawan, live in Wado, My hobby is Coding(maybe) dll',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9D9D9),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9D9D9),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'Message',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        mainAxisExtent: 295,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return ProductCard(title: _products[index].name);
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
