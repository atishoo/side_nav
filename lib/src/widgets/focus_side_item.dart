import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:side_nav/src/models/side_item_model.dart';

class FocusSideItem extends StatefulWidget {
  final Function() onTap;
  final BoxDecoration decoration;
  final bool reversed;
  final double cornerRound;
  final Color focusBackgroundColor;
  final SideItemModel item;
  final EdgeInsets? padding;

  const FocusSideItem({
    required this.decoration,
    required this.onTap,
    required this.reversed,
    required this.item,
    required this.cornerRound,
    required this.focusBackgroundColor,
    this.padding,
  });

  @override
  _FocusSideItemState createState() => _FocusSideItemState();
}

class _FocusSideItemState extends State<FocusSideItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: widget.padding,
            decoration: widget.decoration.copyWith(color: widget.item.focusBackgroundColor ?? widget.focusBackgroundColor),
            child: widget.item.focusMenu == null ? widget.item.menu : widget.item.focusMenu,
          ),
          Positioned(
            top: -widget.cornerRound,
            right: 0,
            child: ClipPath(
              clipper: TopConerClipper(),
              child: Container(
                width: widget.cornerRound,
                height: widget.cornerRound,
                decoration: widget.decoration.copyWith(color: widget.item.focusBackgroundColor ?? widget.focusBackgroundColor),
              ),
            ),
          ),
          Positioned(
            bottom: -widget.cornerRound,
            right: 0,
            child: ClipPath(
              clipper: BottomConerClipper(),
              child: Container(
                width: widget.cornerRound,
                height: widget.cornerRound,
                decoration: widget.decoration.copyWith(color: widget.item.focusBackgroundColor ?? widget.focusBackgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopConerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.arcToPoint(Offset(0, size.height), radius: Radius.circular(size.height), clockwise: true);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomConerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.arcToPoint(Offset(0, 0), radius: Radius.circular(size.height), clockwise: false);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
