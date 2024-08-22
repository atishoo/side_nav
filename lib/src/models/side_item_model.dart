import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SideItemModel extends Equatable {
  final Widget? page;

  final Widget menu;
  final Widget? focusMenu;

  final Function()? onTap;

  final Function()? onMostVisible;

  final Function()? lostFocus;

  final Color? focusBackgroundColor;

  double visibilityPercentage = 0.0;

  bool mostVisible = false;

  SideItemModel({
    required this.page,
    required this.menu,
    this.focusMenu,
    this.onMostVisible,
    this.lostFocus,
    this.onTap,
    this.focusBackgroundColor,
  });

  /// You can compare your side_item_model thanks to Equatable plugin
  ///
  /// For more information:
  /// https://pub.dev/packages/equatable
  @override
  List<Object?> get props => [
        page,
        menu,
        focusMenu,
        visibilityPercentage,
        mostVisible,
        onMostVisible,
        lostFocus,
        focusBackgroundColor,
      ];
}
