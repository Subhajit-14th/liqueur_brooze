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
              icon: Icons.dashboard_rounded,
              text: 'Dashboard',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.inventory_2_rounded,
              text: 'Pages',
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
              icon: Icons.shopping_cart_rounded,
              text: 'Category',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.receipt_long_rounded,
              text: 'Sub Category',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.account_balance_wallet_rounded,
              text: 'Product',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.person_2_rounded,
              text: 'User',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.inventory_2_rounded,
              text: 'Coupon',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.add_shopping_cart_rounded,
              text: 'Shipping Charge',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.cable_rounded,
              text: 'Default Charge',
              onTap: () {},
            ),
            DrawerItem(
              icon: Icons.settings_rounded,
              text: 'Settings',
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
