import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigatorModel {
  String title;
  SvgPicture icon;
  SvgPicture activeIcon;
  Widget navigateTo;

  BottomNavigatorModel(
      {required this.title, required this.icon,required this.activeIcon, required this.navigateTo});
}
