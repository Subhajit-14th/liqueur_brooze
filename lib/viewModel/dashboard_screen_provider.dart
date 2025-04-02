import 'package:flutter/material.dart';
import 'package:liqueur_brooze/controller/DashBoardControllers/dashboard_controllers.dart';
import 'package:liqueur_brooze/model/DashboardModel/dash_board_api_res_model.dart';

class DashboardScreenProvider extends ChangeNotifier {
  DashboardApiResModel _dashboardApiResModel = DashboardApiResModel();
  DashboardApiResModel get dashboardApiResModel => _dashboardApiResModel;
  final DashboardControllers _dashboardControllers = DashboardControllers();

  bool _isDashboardLoad = false;
  bool get isDashboardLoad => _isDashboardLoad;

  /// get dashboard data
  void getDashboardData(context) async {
    _isDashboardLoad = true;
    notifyListeners();
    _dashboardApiResModel =
        await _dashboardControllers.getDashBoardData(context: context);
    if (_dashboardApiResModel.status == 1) {
      _isDashboardLoad = false;
    } else {
      _isDashboardLoad = false;
    }
    notifyListeners();
  }
}
