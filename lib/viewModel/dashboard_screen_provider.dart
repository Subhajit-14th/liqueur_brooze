import 'package:flutter/material.dart';
import 'package:liqueur_brooze/model/dashboardCouponItemsModel.dart';

class DashboardScreenProvider extends ChangeNotifier {
  final List<Dashboardcouponitemsmodel> _couponItems = [
    Dashboardcouponitemsmodel(
      couponType: 'Percentage',
      couponCode: '926F',
      value: '1600',
      startDate: '12/03/2025',
      endingDate: '26/04/2025',
    ),
  ];

  List<Dashboardcouponitemsmodel> get couponItems => _couponItems;
}
