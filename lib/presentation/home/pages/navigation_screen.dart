import 'package:flay_app/presentation/home/pages/cart_screen.dart';
import 'package:flay_app/presentation/home/pages/home_screen.dart';
import 'package:flay_app/presentation/home/pages/profile_screen.dart';
import 'package:flay_app/presentation/home/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';



class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  // Your real pages go here
  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
    WishListScreen(),
    ProfileScreen(),
  ];

  // Icons for each tab
  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.shopping_cart_outlined,
    Icons.favorite_border,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Swap out the body based on the selected tab
      body: _pages[_currentIndex],
      // Custom bottom bar
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        // Rounded top corners to match the UI
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_icons.length, (i) {
          final isSelected = i == _currentIndex;
          return GestureDetector(
            onTap: () => setState(() => _currentIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: isSelected
                  ? const EdgeInsets.all(12)
                  : const EdgeInsets.all(0),
              decoration: isSelected
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    )
                  : null,
              child: Icon(
                _icons[i],
                size: 28,
                color: isSelected ? Colors.black : Colors.grey[600],
              ),
            ),
          );
        }),
      ),
    );
  }
}