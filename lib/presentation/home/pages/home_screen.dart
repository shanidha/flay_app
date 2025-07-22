import 'package:flay_app/core/configs/assets/app_images.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/themes/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // sint _currentNavIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentBanner = 0;
  // Dummy data
  final List<String> _banners = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3,
  ];

  final List<Map<String, String>> _categories = [
    {'icon': 'assets/images/jeans.jpeg', 'label': 'Jeans'},
    {'icon': 'assets/images/skirt.jpeg', 'label': 'Dress'},
    {'icon': 'assets/images/shirt.jpeg', 'label': 'Skirt'},
    {'icon': 'assets/images/top.png', 'label': 'Tops'},
  ];

  final List<Map<String, String>> _latestProducts = [
    {
      'image': 'assets/images/wo.jpeg',
      'title': 'Crop Top',
      'subtitle': 'Oversized',
      'price': 'Rs 720',
    },
    {
      'image': 'assets/images/women.jpeg',
      'title': 'Overcoat Top',
      'subtitle': 'Irregular Rib',
      'price': 'Rs 420',
    },
    {
      'image': 'assets/images/seco.jpeg',
      'title': 'Oversized Top',
      'subtitle': 'Loose Fit',
      'price': 'Rs 549',
    },
    {
      'image': 'assets/images/thirt.jpeg',
      'title': 'Tshirt',
      'subtitle': 'V shaped',
      'price': 'Rs 499',
    },
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(context),
                    const SizedBox(height: 16),
                    _buildBannerCarousel(),
                    const SizedBox(height: 24),
                    //  Indicator dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_banners.length, (idx) {
                        final isActive = idx == _currentBanner;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 16 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                     const SizedBox(height: 24),
                    _buildCategoryScroller(),
                    const SizedBox(height: 24),
                    _buildLatestHeader(),
                    const SizedBox(height: 12),
                    _buildLatestGrid(),
                    const SizedBox(height: 16),
                    _buildPromoBanner(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Text(
            'Flay',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Search', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentBanner = index;
              });
            },
            itemBuilder: (context, index) {
              final image = _banners[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(image, fit: BoxFit.cover),
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: const Text(
                          'Wear the real Fashion',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryScroller() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, i) {
          final cat = _categories[i];
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: const Color(0xFFF2F2F2),
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(cat['icon']!, width: 40, height: 40),
                ),
              ),
              const SizedBox(height: 8),
              Text(cat['label']!, style: const TextStyle(fontSize: 14)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLatestHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Text(
            'Latest',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text('View All', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildLatestGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _latestProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, i) {
          final item = _latestProducts[i];
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(item['image']!, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['subtitle']!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['price']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.favorite_border, size: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: const Color(0xFF2B2D42),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '30% Discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Started several mistake joy painful reached',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: StadiumBorder(),
                      ),
                      child: Text('Shop now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Image.asset(
                  'assets/images/CTA.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildBottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentNavIndex,
  //     onTap: (i) => setState(() => _currentNavIndex = i),
  //     showSelectedLabels: false,
  //     showUnselectedLabels: false,
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
  //       BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
  //       BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
  //       BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
  //     ],
  //   );
  // }

 
}
