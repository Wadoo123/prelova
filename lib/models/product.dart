class Product {
  final String name;
  final int price;
  final double rating;
  final int sold;
  final bool isBestSeller;
  final bool isRecentlyViewed;

  const Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.sold,
    this.isBestSeller = false,
    this.isRecentlyViewed = false,
  });
}
