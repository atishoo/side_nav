# side_nav

本仓库由作者[@Tri7Ratops](https://github.com/Tri7Ratops)创作的[**flutter_side_navbar**](https://github.com/Tri7Ratops/flutter_side_navbar)而来，对这个组件进行了二次修改从而得到了这个组件。

一个仿点餐菜单的边栏导航，自动滚动高亮。


## 开始

在文件`pubspec.yaml`中添加下面的依赖:

```yaml
dependencies:
  ...
  side_nav: any
```

在你的组件中引入:

```dart
import 'package:side_nav/side_nav.dart';
```

## 使用

First, add `SideNavbar` in your `Scaffold`:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SideNavbar(
          pages: [],
        ),
      ),
    );
  }
}
```

Then, add your different `pages` as a list of `Widget`:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SideNavbar(
          pages: [
            SideItemModel(
              defaultIconColor: Colors.blue,
              onTap: () {},
              page: Column(
                children: [
                  Container(
                    height: 800,
                    width: double.infinity,
                    color: Colors.green,
                  ),
                ],
              ),
              icon: Icons.home_filled,
            ),
            SideItemModel(
              defaultIconColor: Colors.blue,
              onTap: () {},
              page: Column(
                children: [
                  Container(
                    height: 1000,
                    width: double.infinity,
                    color: Colors.red,
                  ),
                ],
              ),
              icon: Icons.verified_user,
            ),
          ],
        ),
      ),
    );
  }
}
```

You're now ready to go !

## Customize

### SideItemModel

```dart
  /// Widget to show
  final Widget? page;

  /// Icon showed according to the page in the navigation
  final IconData icon;

  /// Used as a complement of the icon
  final String? iconTitle;

  /// Used for specific development when the user click on the icon in the navigation
  final Function()? onTap;

  /// Used for specific development when the widget is the most visible
  final Function()? onMostVisible;

  /// Used for specific development when the widget lost focus
  final Function()? lostFocus;

  /// Default color of the icon when the page is not the most visible
  final Color defaultIconColor;

  /// Background color of the navigation item when the corresponding page is focused
  final Color focusBackgroundColor;

  /// Icon color of the navigation item when the corresponding page is focused
  final Color focusIconColor;

  /// Text color of the navigation item when the corresponding page is focused
  final Color focusTextColor;
```

### SideNavbar
```dart
  /// List of all the pages to show
  final List<SideItemModel> pages;

  /// Widget of navigationWidth
  final double navigationWidth;

  /// Navigation background color
  final Color navigationBackgroundColor;

  /// Used to personalised the container of the navigation buttons
  final BoxDecoration decorationItem;

  /// Used to change the position of the navigation
  ///
  /// reversed = false ==> Navigation on the right
  /// reversed = true ==> Navigation on the left
  final bool reversed;

  /// Used to specify to the package if an AppBar is shown
  final bool appBarIsShown;

  /// Used to set the padding for the page
  final EdgeInsets? padding;

  /// Used to set the padding of the navigation
  final EdgeInsets? paddingNavigation;

  /// If the scroll view does not shrink wrap, then the scroll view will expand to the maximum allowed size
  final bool shrinkWrap;

  /// Used to set the scroll controller of the package for specific development
  final AutoScrollController? controller;

  /// Used to set the scroll physics of the package
  final ScrollPhysics? physics;

  /// Used to set the duration of the animation when a user tap on a navigation item's and the scroll is moving
  final Duration duration;
```

## Examples

Basic: [example](https://github.com/atishoo/side_nav/blob/master/example/lib/screens/side_navbar_pages/basic.dart)

Reversed: [example](https://github.com/atishoo/side_nav/blob/master/example/lib/screens/side_navbar_pages/basic_reversed.dart)

Basic with AppBar: [example](https://github.com/atishoo/side_nav/blob/master/example/lib/screens/side_navbar_pages/basic_with_appbar.dart)

Inside another scroll widget: [example](https://github.com/atishoo/side_nav/blob/master/example/lib/screens/side_navbar_pages/scrollable.dart)

Inside another scroll widget + AppBar: [example](https://github.com/atishoo/side_nav/blob/master/example/lib/screens/side_navbar_pages/scrollable_with_appbar.dart)

## 使用的包

`equatable`: [https://pub.dev/packages/equatable](https://pub.dev/packages/equatable)

`scroll_to_index`: [https://pub.dev/packages/scroll_to_index](https://pub.dev/packages/scroll_to_index)

`visibility_detector`: [https://pub.dev/packages/visibility_detector](https://pub.dev/packages/visibility_detector)
