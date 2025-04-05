import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/view/AddCouponScreen/coupon_screen.dart';
import 'package:liqueur_brooze/view/Category/category_screen.dart';
import 'package:liqueur_brooze/view/DashboardScreen/dashboard_screen.dart';
import 'package:liqueur_brooze/view/Drawer/admin_panel.dart';
import 'package:liqueur_brooze/view/Pages/pages_screen.dart';
import 'package:liqueur_brooze/view/ProductScreen/product_screen.dart';
import 'package:liqueur_brooze/view/ShippingCharge/shipping_charge_screen.dart';
import 'package:liqueur_brooze/view/SubCategory/sub_category_screen.dart';
import 'package:liqueur_brooze/viewModel/router_provider.dart';
import 'package:provider/provider.dart';

class MainRouteScreen extends StatelessWidget {
  const MainRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routerProvider = Provider.of<RouterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          routerProvider.pageHeading[routerProvider.pageIndex],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Monserat',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      drawer: const AdminDrawer(),
      body: [
        DashboardScreen(),
        PagesScreen(),
        CategoryScreen(),
        SubCategoryScreen(),
        ProductScreen(),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'Comming Soon',
              style: TextStyle(
                color: AppColor.darkTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monserat',
              ),
            ),
          ),
        ),
        CouponScreen(),
        ShippingChargeScreen(),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueAccent,
        ),
      ][routerProvider.pageIndex],
    );
  }
}
