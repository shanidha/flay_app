import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar('Profile'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/images/user.jpg')),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Amaira Shifan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('amira414@gmail.com', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...[
            ['My Orders', Icons.shopping_bag_outlined],
            ['Wishlist', Icons.favorite_border],
            ['Help Center', Icons.headset_mic_outlined],
            ['Manage Address', Icons.location_on_outlined],
            ['Payment Method', Icons.credit_card_outlined],
            ['Account Details', Icons.person_outline],
            ['Settings', Icons.settings_outlined],
          ].map((e) => _buildProfileTile(e[0] as String, e[1] as IconData)),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('LOGOUT'),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) => AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('Flay', style: const TextStyle(color: Colors.black)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined, color: Colors.black54))],
      );

  Widget _buildProfileTile(String label, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
        onTap: () {},
      ),
    );
  }
}