import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/viewModel/dashboard_screen_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    /// Call get dashboard data api when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardScreenProvider>(context, listen: false)
          .getDashboardData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<DashboardScreenProvider>(
        builder: (context, dashboardProvider, child) {
      if (dashboardProvider.isDashboardLoad) {
        return Container(
          height: height,
          width: width,
          color: Colors.black.withAlpha(50), // Dim background
          child: const Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: LoadingIndicator(
                indicatorType: Indicator.ballZigZag,
                colors: [AppColor.primaryColor, AppColor.secondaryColor],
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.black,
              ),
            ),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            buildDashboardCard(
              title: "Sales",
              subtitle: "Today",
              value:
                  "${dashboardProvider.dashboardApiResModel.data?.sales?.amount}",
              percentage:
                  "${dashboardProvider.dashboardApiResModel.data?.sales?.percentage}",
              percentageColor: Colors.green,
              icon: Icons.shopping_cart,
              iconColor: Colors.blue,
              changeText: "increase",
            ),
            SizedBox(height: 16), // Add spacing between cards
            buildDashboardCard(
              title: "Revenue",
              subtitle: "This Month",
              value:
                  "${dashboardProvider.dashboardApiResModel.data?.revenue?.amount}",
              percentage:
                  "${dashboardProvider.dashboardApiResModel.data?.revenue?.percentage}",
              percentageColor: Colors.green,
              icon: Icons.attach_money,
              iconColor: Colors.green,
              changeText: "increase",
            ),
            SizedBox(height: 16),
            buildDashboardCard(
              title: "Customers",
              subtitle: "This Year",
              value:
                  "${dashboardProvider.dashboardApiResModel.data?.totalCustomers?.amount}",
              percentage:
                  "${dashboardProvider.dashboardApiResModel.data?.totalCustomers?.percentage}",
              percentageColor: Colors.red,
              icon: Icons.people,
              iconColor: Colors.orange,
              changeText: "decrease",
            ),
          ],
        ),
      );
    });
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
