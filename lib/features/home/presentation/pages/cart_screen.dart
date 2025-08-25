import 'package:flay_app/core/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';

import 'wishlist_screen.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final sampleCart = [
  Product('assets/images/thirt.jpeg', 'Shirt', 'Box shape full sleeve', 'Rs 3290', 'L'),
  Product('assets/images/women.jpeg', 'Coat Top', 'OverCoat', 'Rs 294 30% OFF', 'M'),
  Product('assets/images/wo.jpeg', 'Oversized Top', 'Box shape full sleeve', 'Rs 440 20% OFF', 'S'),
  Product('assets/images/seco.jpeg', 'Skirt', 'Short Cut', 'Rs 459', 'L'),
];
    return Scaffold(
      appBar: _buildAppBar('Flay'),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sampleCart.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (c, i) => _buildCartItem(c, sampleCart[i]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '${sampleCart.length} items selected for order',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 350,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
              label: const Text('PLACE ORDER',style: TextStyle(color: AppColors.background),),
              style: ElevatedButton.styleFrom(
                
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) => AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(title, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined, color: Colors.black54)),
        ],
      );

  Widget _buildCartItem(BuildContext c, Product p) {
    return Card(
      
      color: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(p.image, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(p.subtitle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            ),
           
          ],
        ),
      ),
    );
  }
}
