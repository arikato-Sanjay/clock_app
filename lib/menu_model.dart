import 'package:clock_app/enums.dart';
import 'package:flutter/foundation.dart';

//created model
class MenuType extends ChangeNotifier{
  MenuList menuList;
  String title;
  String imgSource;

  MenuType(this.menuList, {this.title, this.imgSource});

  updatingMenu(MenuType menuType){
    this.menuList = menuType.menuList;
    this.title = menuType.title;
    this.imgSource = menuType.imgSource;

    //notifying all listeners ie consumers
    notifyListeners();
  }
}