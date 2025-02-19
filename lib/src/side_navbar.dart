import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:side_nav/src/models/models.dart';
import 'package:side_nav/src/widgets/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SideNavbar extends StatefulWidget {
  final List<SideItemModel> pages;
  final double navigationWidth;
  final double cornerRound;
  final Color navigationBackgroundColor;
  final Color focusNavigationBackgroundColor;
  final BoxDecoration decorationItem;

  /// false: 导航在右侧
  /// false: 导航在左侧
  final bool reversed;

  final bool appBarIsShown;
  final EdgeInsets? menuPadding;
  final EdgeInsets? pagePadding;
  final EdgeInsets? paddingNavigation;

  /// If the scroll view does not shrink wrap, then the scroll view will expand to the maximum allowed size
  final bool shrinkWrap;

  /// Used to set the scroll controller of the package for specific development
  final AutoScrollController? controller;

  /// Used to set the scroll physics of the package
  final ScrollPhysics? physics;

  /// Used to set the duration of the animation when a user tap on a navigation item's and the scroll is moving
  final Duration duration;

  SideNavbar({
    Key? key,
    required this.pages,
    this.navigationWidth = 75,
    this.navigationBackgroundColor = Colors.white10,
    this.focusNavigationBackgroundColor = Colors.grey,
    this.menuPadding,
    this.pagePadding,
    this.cornerRound = 0,
    this.paddingNavigation = const EdgeInsets.all(10),
    this.reversed = false,
    this.shrinkWrap = false,
    this.appBarIsShown = false,
    this.duration = const Duration(milliseconds: 400),
    this.controller,
    this.physics,
    BoxDecoration? menuContainerDecoration,
  })  : decorationItem = menuContainerDecoration ?? BoxDecoration(),
        super(key: key);

  @override
  _SideNavbarState createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  /// Used to scroll to a specific page
  late AutoScrollController _controller;

  /// Used to determine the maxHeight of all the pages
  GlobalKey _keyList = GlobalKey();

  /// Used for the scroll when a user change the current page
  double position = 0;

  @override
  void initState() {
    /// The controller can't be null
    /// So if bo controller is given in parameters, we define one
    _controller = widget.controller ??
        AutoScrollController(
          viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
          axis: Axis.vertical,
        );

    /// Set by default the first page non null to be the most visible
    for (SideItemModel item in widget.pages) {
      if (item.page != null) {
        item.mostVisible = true;
        break;
      }
    }

    /// After the post frame callback, update the page because the currentContext can't be known during the build
    /// and the navigation have a size of 0
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reversed) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              top: position,
              left: 0,
              child: _getNavigationColumn(context),
            ),
            Container(
              margin: EdgeInsets.only(left: widget.navigationWidth),
              child: _getPagesColumn(),
            ),
          ],
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          _getPagesColumn(),
          AnimatedPositioned(
            duration: widget.duration,
            curve: Curves.fastOutSlowIn,
            top: position,
            right: 0,
            child: _getNavigationColumn(context),
          ),
        ],
      ),
    );
  }

  _getSizes() {
    /// Get the current context of the ListView who contains all the pages
    BuildContext? currentCxt = _keyList.currentContext;
    if (currentCxt == null) return;

    /// Get the renderBox of the ListView
    final RenderBox? renderBox = currentCxt.findRenderObject() as RenderBox;

    /// Used to get the position of the ListView
    final pos = renderBox!.localToGlobal(Offset.zero);

    /// Used to get the navigation padding set by the user
    double paddingNav = widget.paddingNavigation != null ? widget.paddingNavigation!.top : 0;

    /// Used to get the padding of the page (iOS)
    final double paddingMedia = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;

    /// ListView position
    double posi = -pos.dy;

    /// ListView base position
    double basicPos = (widget.appBarIsShown ? AppBar().preferredSize.height : 0) + paddingNav + paddingMedia;

    /// ListView base position
    double posiTrue = widget.shrinkWrap && widget.appBarIsShown ? 0 : paddingMedia;

    /// Used to determine the position to set to navigation
    double posiFalse = -pos.dy + (widget.shrinkWrap ? AppBar().preferredSize.height - (widget.appBarIsShown ? -14 : 28) : 0) + 8 + paddingNav;

    double navigationPos = (posi < basicPos) ? posiTrue : posiFalse;

    /// Used to avoid the navigation to go out of the constraints of the ListView
    /// More particularly for the end of the ListView
    if (navigationPos != posiTrue && navigationPos + MediaQuery.of(context).size.height >= renderBox.size.height) {
      navigationPos = renderBox.size.height - MediaQuery.of(context).size.height + (widget.appBarIsShown || widget.shrinkWrap ? AppBar().preferredSize.height : 0) + paddingNav + paddingMedia + 8;
    }

    if (this.mounted && navigationPos != position) {
      setState(() => position = navigationPos);
    }
  }

  _defineMostVisiblePage() {
    /// Current most visible page
    SideItemModel? mostItemVisible;

    /// Old most visible page
    SideItemModel? lastMostItemVisible;

    /// Go thought all the pages to determine the most visible
    for (SideItemModel item in widget.pages) {
      if (item.mostVisible) {
        lastMostItemVisible = item;
      }
      item.mostVisible = false;

      /// Compare the current item in the list if it's most visible than the current found
      if (item.page != null && (mostItemVisible == null || item.visibilityPercentage > mostItemVisible.visibilityPercentage)) {
        mostItemVisible = item;
      }
    }
    mostItemVisible?.mostVisible = true;

    if (mostItemVisible != lastMostItemVisible && this.mounted) {
      if (this.mounted) setState(() {});

      lastMostItemVisible?.lostFocus?.call();

      mostItemVisible?.onMostVisible?.call();
    }
  }

  Widget _getPagesColumn() {
    return Container(
      key: _keyList,
      width: MediaQuery.of(context).size.width - widget.navigationWidth,
      child: ListView.builder(
        physics: widget.physics,
        padding: widget.pagePadding,
        shrinkWrap: widget.shrinkWrap,
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          return VisibilityDetector(
            key: Key('INDEX-flutter-side-navbar-$index'),
            onVisibilityChanged: (visibilityInfo) {
              _getSizes();

              widget.pages[index].visibilityPercentage = visibilityInfo.visibleFraction * 100;

              _defineMostVisiblePage();
            },
            child: AutoScrollTag(
              key: ValueKey(index),
              controller: _controller,
              index: index,
              child: widget.pages[index].page ?? Container(),
            ),
          );
        },
      ),
    );
  }

  Widget _getNavigationColumn(BuildContext context) {
    /// Get the current context of the ListView who contains all of the pages
    BuildContext? currentCxt = _keyList.currentContext;
    if (currentCxt == null) {
      return Container();
    }

    /// Get the padding of the screen (iOS)
    final double paddingMedia = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;

    /// Get the padding set by the user
    final double paddingNavigation = widget.paddingNavigation != null ? (widget.paddingNavigation!.top + widget.paddingNavigation!.bottom) : 0.0;

    /// Get the renderBow of the ListView with the constaints
    final RenderBox? renderBox = currentCxt.findRenderObject() as RenderBox;

    /// Remove the padding from the maxHeight available to the ListView
    final heightContainerConstraint = renderBox!.constraints.maxHeight - paddingMedia;

    /// Specific heightContainer calculation when the heightContainerConstraint is infinite
    final heightContainer = MediaQuery.of(context).size.height - paddingMedia - paddingNavigation - (widget.appBarIsShown || widget.shrinkWrap ? kToolbarHeight : 0);

    return Container(
      height: heightContainerConstraint.isInfinite ? heightContainer : heightContainerConstraint,
      padding: widget.paddingNavigation,
      width: widget.navigationWidth,
      color: widget.navigationBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _getNavigationItems(),
      ),
    );
  }

  List<Widget> _getNavigationItems() {
    List<Widget> list = [];

    for (SideItemModel item in widget.pages) {
      int index = widget.pages.indexOf(item);

      if (item.mostVisible) {
        list.add(
          FocusSideItem(
            onTap: () {
              _scrollTo(item, index);
            },
            cornerRound: widget.cornerRound,
            reversed: widget.reversed,
            padding: widget.menuPadding,
            decoration: widget.decorationItem,
            focusBackgroundColor: widget.focusNavigationBackgroundColor,
            item: item,
          ),
        );
      } else {
        list.add(
          DefaultSideItem(
            decoration: widget.decorationItem,
            padding: widget.menuPadding,
            onTap: () {
              _scrollTo(item, index);
            },
            item: item,
          ),
        );
      }
    }
    return list;
  }

  _scrollTo(SideItemModel item, int index) {
    item.onTap?.call();

    _controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);

    _controller.highlight(index);
  }
}
