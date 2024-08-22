import 'package:example/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:side_nav/side_nav.dart';

class Basic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SideNavbar(
          navigationBackgroundColor: Colors.black,
          pages: [
            SideItemModel(
              onTap: () {},
              page: Column(
                children: [
                  Utils.backButton(context),
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
              menu: Icon(Icons.home_filled),
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
      ),
    );
  }
}
