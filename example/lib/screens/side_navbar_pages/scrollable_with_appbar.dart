import 'package:example/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:side_nav/side_nav.dart';

class ScrollableWithAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Sample Code'),
        ),
        backgroundColor: Colors.white70,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Utils.getContainer(height: 300, color: Colors.yellow),
              SideNavbar(
                shrinkWrap: true,
                appBarIsShown: true,
                physics: const NeverScrollableScrollPhysics(),
                navigationBackgroundColor: Colors.black,
                pages: [
                  SideItemModel(
                    menu: Icon(Icons.home_filled),
                    onTap: () {},
                    page: Column(
                      children: [
                        Utils.getContainer(
                          height: 100,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 300,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 50,
                          color: Colors.red,
                        ),
                        Utils.getContainer(
                          height: 200,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  SideItemModel(
                    menu: Icon(Icons.verified_user),
                    onTap: () {},
                    page: Column(
                      children: [
                        Utils.getContainer(
                          height: 400,
                          color: Colors.green,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.green,
                        ),
                        Utils.getContainer(
                          height: 200,
                          color: Colors.green,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  SideItemModel(
                    menu: Icon(Icons.lock_clock),
                    onTap: () {},
                    page: Column(
                      children: [
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                        Utils.getContainer(
                          height: 100,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Utils.getContainer(height: 300, color: Colors.lightGreen),
            ],
          ),
        ),
      ),
    );
  }
}
