import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../data/tu_chong_repository.dart';
import '../../data/tu_chong_source.dart';
import '../../widget/item_builder.dart';

@FFRoute(
  name: 'fluttercandies://NestedScrollViewDemo',
  routeName: 'NestedScrollView',
  description:
      'Show how to build loading more list in NestedScrollView quickly',
  exts: <String, dynamic>{
    'group': 'Complex',
    'order': 1,
  },
)
class NestedScrollViewDemo extends StatefulWidget {
  @override
  _NestedScrollViewDemoState createState() => _NestedScrollViewDemoState();
}

class _NestedScrollViewDemoState extends State<NestedScrollViewDemo>
    with TickerProviderStateMixin {
  late TuChongRepository listSourceRepository;
  late TuChongRepository listSourceRepository1;
  late TuChongRepository listSourceRepository2;
  late TuChongRepository listSourceRepository3;
  late TabController primaryTC;
  @override
  void initState() {
    listSourceRepository = TuChongRepository();
    listSourceRepository1 = TuChongRepository();
    listSourceRepository2 = TuChongRepository();
    listSourceRepository3 = TuChongRepository();
    primaryTC = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    listSourceRepository.dispose();
    listSourceRepository1.dispose();
    listSourceRepository2.dispose();
    listSourceRepository3.dispose();
    primaryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final TabBar primaryTabBar = TabBar(
      controller: primaryTC,
      labelColor: Colors.blue,
      indicatorColor: Colors.blue,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2.0,
      isScrollable: false,
      unselectedLabelColor: Colors.grey,
      tabs: const <Tab>[
        Tab(text: 'Tab0'),
        Tab(text: 'Tab1'),
        Tab(text: 'Tab2'),
      ],
    );
    final double tabBarHeight = primaryTabBar.preferredSize.height;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight +
            //pinned tabbar height in header
            tabBarHeight;

    return Scaffold(
      body: PullToRefreshNotification(
        color: Colors.blue,
        pullBackOnRefresh: true,
        onRefresh: onRefresh,
        maxDragOffset: 100.0,
        child: ExtendedNestedScrollView(
          physics: const ClampingScrollPhysics(),
          pinnedHeaderSliverHeightBuilder: () {
            return pinnedHeaderHeight;
          },
          onlyOneScrollInBody: true,
          headerSliverBuilder: (BuildContext c, bool? f) {
            final List<Widget> widgets = <Widget>[];
            widgets.add(PullToRefreshContainer(builderAppbar));
            widgets.add(SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: CommonSliverPersistentHeaderDelegate(
                    Container(
                      child: primaryTabBar,
                      //color: Colors.white,
                    ),
                    primaryTabBar.preferredSize.height)));

            return widgets;
          },
          body: TabBarView(controller: primaryTC, children: <Widget>[
            Tab0(listSourceRepository),
            Tab1(listSourceRepository1, listSourceRepository2),
            Tab2(listSourceRepository3),
          ]),
        ),
      ),
    );
  }

  Widget builderAppbar(PullToRefreshScrollNotificationInfo? info) {
    Widget action = Padding(
      child: info?.refreshWidget ?? const Icon(Icons.more_horiz),
      padding: const EdgeInsets.all(15.0),
    );
    final double offset = info?.dragOffset ?? 0.0;
    Widget child = Container();
    if (info != null) {
      if (info.mode == PullToRefreshIndicatorMode.error) {
        child = GestureDetector(
          onTap: () {
            // refreshNotification;
            info.pullToRefreshNotificationState.show();
          },
          child: Text(
            (info.mode?.toString() ?? '') + '  click to retry',
            style: const TextStyle(fontSize: 10.0),
          ),
        );
        action = Container();
      } else {
        child = Text(
          info.mode.toString(),
          style: const TextStyle(fontSize: 10.0),
        );
      }
    }

    return SliverAppBar(
        pinned: true,
        title: const Text('NestedScrollViewDemo'),
        centerTitle: true,
        expandedHeight: 200.0 + offset,
        actions: <Widget>[action],
        flexibleSpace: FlexibleSpaceBar(
            //centerTitle: true,
            title: child,
            collapseMode: CollapseMode.pin,
            background: Image.asset(
              'assets/467141054.jpg',
              //fit: offset > 0.0 ? BoxFit.cover : BoxFit.fill,
              fit: BoxFit.cover,
            )));
  }

  Future<bool> onRefresh() async {
    print('onRefresh');
    if (primaryTC.index == 0) {
      return await listSourceRepository.refresh(false);
    } else if (primaryTC.index == 1) {
      listSourceRepository2.clear();
      return await listSourceRepository1.refresh(true);
    } else if (primaryTC.index == 2) {
      return await listSourceRepository3.refresh(true);
    }
    return true;
  }
}

class CommonSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CommonSliverPersistentHeaderDelegate(this.child, this.height);
  final Widget child;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(CommonSliverPersistentHeaderDelegate oldDelegate) {
    //print('shouldRebuild---------------');
    return oldDelegate != this;
  }
}

class Tab0 extends StatefulWidget {
  const Tab0(this.listSourceRepository);
  final TuChongRepository? listSourceRepository;
  @override
  _Tab0State createState() => _Tab0State();
}

class _Tab0State extends State<Tab0> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingMoreCustomScrollView(
      showGlowLeading: false,
      //rebuildCustomScrollView: true,
      physics: const ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            color: Colors.red,
            child: const Text(
                'This is a single sliver List with no pinned header'),
            //color: Colors.white,
          ),
        ),
        LoadingMoreSliverList<TuChongItem>(SliverListConfig<TuChongItem>(
          itemBuilder: itemBuilder,
          sourceList: widget.listSourceRepository!,
          //isLastOne: false
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Tab1 extends StatefulWidget {
  const Tab1(this.listSourceRepository1, this.listSourceRepository2);
  final TuChongRepository? listSourceRepository1;
  final TuChongRepository? listSourceRepository2;
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingMoreCustomScrollView(
      showGlowLeading: false,
      cacheExtent: 1000,
      physics: const ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverPinnedToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            color: Colors.red,
            child: const Text(
                'This is a multiple loading sliver List with pinned header'),
            //color: Colors.white,
          ),
        ),
        LoadingMoreSliverList<TuChongItem>(SliverListConfig<TuChongItem>(
          itemBuilder: itemBuilder,
          sourceList: widget.listSourceRepository1!,
          //isLastOne: false
        )),
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            child: const Text('Next list'),
            color: Colors.blue,
            height: 100.0,
          ),
        ),
        LoadingMoreSliverList<TuChongItem>(SliverListConfig<TuChongItem>(
          itemBuilder: itemBuilder,
          sourceList: widget.listSourceRepository2!,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
//                    childAspectRatio: 0.5
          ),
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Tab2 extends StatefulWidget {
  const Tab2(this.listSourceRepository3);
  final TuChongRepository? listSourceRepository3;
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Container(
          height: 50.0,
          child: const Text('This is a single ListView with pinned header'),
          color: Colors.red,
          alignment: Alignment.center,
        ),
        Expanded(
          child: LoadingMoreList<TuChongItem>(
            ListConfig<TuChongItem>(
                itemBuilder: itemBuilder,
                sourceList: widget.listSourceRepository3!,
                showGlowLeading: false,
                physics: const ClampingScrollPhysics(),
//                    showGlowTrailing: false,
                padding: const EdgeInsets.all(0.0)),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
