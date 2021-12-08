// GENERATED CODE - DO NOT MODIFY MANUALLY
// **************************************************************************
// Auto generated by https://github.com/fluttercandies/ff_annotation_route
// **************************************************************************
// ignore_for_file: prefer_const_literals_to_create_immutables,unused_local_variable,unused_import
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/widgets.dart';

import 'demo/complex/nested_scroll_view_demo.dart';
import 'demo/complex/waterfall_flow_demo.dart';
import 'demo/main_page.dart';
import 'demo/simple/custom_indicator_demo.dart';
import 'demo/simple/grid_view_demo.dart';
import 'demo/simple/list_view_demo.dart';
import 'demo/simple/multiple_sliver_demo.dart';
import 'demo/simple/sliver_grid_demo.dart';
import 'demo/simple/sliver_list_demo.dart';

FFRouteSettings getRouteSettings({
  required String name,
  Map<String, dynamic>? arguments,
  PageBuilder? notFoundPageBuilder,
}) {
  final Map<String, dynamic> safeArguments =
      arguments ?? const <String, dynamic>{};
  switch (name) {
    case 'fluttercandies://CustomIndicatorDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => CustomIndicatorDemo(),
        routeName: 'CustomIndicator',
        description:
            'Show how to build loading more list with custom indicator quickly',
        exts: <String, dynamic>{'group': 'Simple', 'order': 2},
      );
    case 'fluttercandies://GridViewDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => GridViewDemo(),
        routeName: 'GridView',
        description: 'Show how to build loading more GridView quickly',
        exts: <String, dynamic>{'group': 'Simple', 'order': 1},
      );
    case 'fluttercandies://ListViewDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => ListViewDemo(),
        routeName: 'ListView',
        description: 'Show how to build loading more ListView quickly',
        exts: <String, dynamic>{'group': 'Simple', 'order': 0},
      );
    case 'fluttercandies://MultipleSliverDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => MultipleSliverDemo(),
        routeName: 'MultipleSliver',
        description:
            'Show how to build loading more multiple sliver list quickly',
        exts: <String, dynamic>{'group': 'Simple', 'order': 5},
      );
    case 'fluttercandies://NestedScrollViewDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => NestedScrollViewDemo(),
        routeName: 'NestedScrollView',
        description:
            'Show how to build loading more list in NestedScrollView quickly',
        exts: <String, dynamic>{'group': 'Complex', 'order': 1},
      );
    case 'fluttercandies://SliverGridDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => SliverGridDemo(),
        routeName: 'SliverGrid',
        description: 'Show how to build loading more SilverGird quickly',
        exts: <String, dynamic>{'group': 'Simple', 'order': 4},
      );
    case 'fluttercandies://SliverListDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => SliverListDemo(),
        routeName: 'SliverList',
        description: 'Show how to build loading more SliverList quickly',
        exts: <String, dynamic>{'group': 'Simple', 'order': 3},
      );
    case 'fluttercandies://WaterfallFlowDemo':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => WaterfallFlowDemo(),
        routeName: 'WaterfallFlow',
        description: 'Show how to build loading more WaterfallFlow quickly',
        exts: <String, dynamic>{'group': 'Complex', 'order': 0},
      );
    case 'fluttercandies://demogrouppage':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => DemoGroupPage(
          keyValue: asT<MapEntry<String, List<DemoRouteResult>>>(
            safeArguments['keyValue'],
          )!,
        ),
        routeName: 'DemoGroupPage',
      );
    case 'fluttercandies://mainpage':
      return FFRouteSettings(
        name: name,
        arguments: arguments,
        builder: () => MainPage(),
        routeName: 'MainPage',
      );
    default:
      return FFRouteSettings(
        name: FFRoute.notFoundName,
        routeName: FFRoute.notFoundRouteName,
        builder: notFoundPageBuilder ?? () => Container(),
      );
  }
}
