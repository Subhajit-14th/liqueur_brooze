import 'package:flutter/material.dart';
import 'package:liqueur_brooze/add_category.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: MediaQuery.of(context).size.width / 1.8,
      child: Container(
        color: AppColor.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              child: Text(
                'Admin Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.category,
              text: 'Add Category',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCategoryScreen(),
                  ),
                );
              },
            ),
            DrawerItem(
              icon: Icons.add,
              text: 'Add Products',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.update,
              text: 'Update Products',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.delete,
              text: 'Delete Products',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.shopping_cart,
              text: 'Cart Items',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.location_on,
              text: 'Locations',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.card_giftcard,
              text: 'Coupon',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
