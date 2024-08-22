import 'package:flutter/cupertino.dart';
import 'package:side_nav/src/models/models.dart';

class DefaultSideItem extends StatelessWidget {
  final Function() onTap;
  final BoxDecoration decoration;
  final SideItemModel item;
  final EdgeInsets? padding;

  const DefaultSideItem({
    required this.decoration,
    required this.onTap,
    required this.item,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: decoration,
        child: item.menu,
      ),
    );
  }
}
