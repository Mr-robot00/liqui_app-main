import 'package:liqui_app/global/analytics/branch_setup.dart';
import 'package:liqui_app/global/analytics/mix_panel_setup.dart';
import 'package:liqui_app/global/analytics/moengage_setup.dart';

 Future<void> initialiseAnalytics() async {
  mixPanel.initialise();
  branchIO.initialise();
  moEngage.initialise();
}