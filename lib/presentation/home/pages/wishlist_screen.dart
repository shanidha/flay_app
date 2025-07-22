import 'package:flay_app/core/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Sample data
    final sampleWishlist = [
      Product(
        'assets/images/thirt.jpeg',
        'Shirt',
        'Box shape full sleeve',
        'Rs 3290',
        'L',
      ),
      Product(
        'assets/images/women.jpeg',
        'Coat Top',
        'OverCoat',
        'Rs 294 30% OFF',
        'M',
      ),
      Product(
        'assets/images/wo.jpeg',
        'Oversized Top',
        'Box shape full sleeve',
        'Rs 440 20% OFF',
        'S',
      ),
      Product('assets/images/seco.jpeg', 'Skirt', 'Short Cut', 'Rs 459', 'L'),
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
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search, color: Colors.black54),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_outlined, color: Colors.black54),
      ),
    ],
    centerTitle: false,
  );

  Widget _buildWishListItem(BuildContext c, Product p) {
    return Card(
      color: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ——— Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                p.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

      
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               
                  Text(
                    p.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${p.subtitle}\nSize: ${p.size}',
                    style: const TextStyle(height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

        
            SizedBox(
              width: 80, 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Remove button
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                  const SizedBox(height: 8),

                  // Add to cart
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 6,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(0, 0),
                    ),
                    child: const Text('Add to Cart', style: TextStyle(fontSize: 12,color: AppColors.background)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// product model
class Product {
  final String image, title, subtitle, price, size;
  Product(this.image, this.title, this.subtitle, this.price, this.size);
}
