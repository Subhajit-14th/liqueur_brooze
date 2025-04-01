import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/view/AddCouponScreen/add_coupon_screen.dart';
import 'package:liqueur_brooze/view/DashboardScreen/coupon_delete_dialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          SizedBox(height: 16),
          buildDashboardCard(
            title: "Sales",
            subtitle: "Today",
            value: "145",
            percentage: "12%",
            percentageColor: Colors.green,
            icon: Icons.shopping_cart,
            iconColor: Colors.blue,
            changeText: "increase",
          ),
          SizedBox(height: 16), // Add spacing between cards
          buildDashboardCard(
            title: "Revenue",
            subtitle: "This Month",
            value: "\$3,264",
            percentage: "8%",
            percentageColor: Colors.green,
            icon: Icons.attach_money,
            iconColor: Colors.green,
            changeText: "increase",
          ),
          SizedBox(height: 16),
          buildDashboardCard(
            title: "Customers",
            subtitle: "This Year",
            value: "1244",
            percentage: "12%",
            percentageColor: Colors.red,
            icon: Icons.people,
            iconColor: Colors.orange,
            changeText: "decrease",
          ),
        ],
      ),
    );
  }

  Widget buildDashboardCard({
    required String title,
    required String subtitle,
    required String value,
    required String percentage,
    required Color percentageColor,
    required IconData icon,
    required Color iconColor,
    required String changeText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "$title ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900]),
                    children: [
                      TextSpan(
                        text: "| $subtitle",
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.blueGrey),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: iconColor.withOpacity(0.2),
                  radius: 20,
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[900]),
                    ),
                    Row(
                      children: [
                        Text(
                          percentage,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: percentageColor),
                        ),
                        Text(
                          " $changeText",
                          style:
                              TextStyle(fontSize: 14, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
