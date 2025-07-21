import 'package:flutter/material.dart';
class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  @override
  Widget build(BuildContext context) {

    // Sample data
final sampleWishlist = [
  Product('assets/images/shirt.jpg', 'Shirt', 'Box shape full sleeve', 'Rs 3290', 'L'),
  Product('assets/images/coat_top.jpg', 'Coat Top', 'OverCoat', 'Rs 420', 'M'),
  Product('assets/images/oversized_top.jpg', 'Oversized Top', 'Box shape full sleeve', 'Rs 549', 'S'),
  Product('assets/images/skirt.jpg', 'Skirt', 'Short Cut', 'Rs 459', 'L'),
];

    return Scaffold(
      appBar: _buildAppBar('Wishlist'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sampleWishlist.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final p = sampleWishlist[i];
          return _buildWishListItem(context, p);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) => AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(title, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black54)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined, color: Colors.black54)),
        ],
        centerTitle: false,
      );

  Widget _buildWishListItem(BuildContext c, Product p) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(p.image, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${p.subtitle}\nSize : ${p.size}', style: const TextStyle(height: 1.4)),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Add to cart', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
// Dummy product model
class Product {
  final String image, title, subtitle, price, size;
  Product(
    this.image,
    this.title,
    this.subtitle,
    this.price,
    this.size,
  );
}