// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart = 2.8

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// Defines the title font used for [CustomListTile] descendants of a [CustomListTileTheme].
///
/// List tiles that appear in a [Drawer] use the theme's [TextTheme.bodyText1]
/// text style, which is a little smaller than the theme's [TextTheme.subtitle1]
/// text style, which is used by default.
enum CustomListTileStyle {
  /// Use a title font that's appropriate for a [CustomListTile] in a list.
  list,

  /// Use a title font that's appropriate for a [CustomListTile] that appears in a [Drawer].
  drawer,
}

/// An inherited widget that defines color and style parameters for [CustomListTile]s
/// in this widget's subtree.
///
/// Values specified here are used for [CustomListTile] properties that are not given
/// an explicit non-null value.
///
/// The [Drawer] widget specifies a tile theme for its children which sets
/// [style] to [CustomListTileStyle.drawer].
class CustomListTileTheme extends InheritedTheme {
  /// Creates a list tile theme that controls the color and style parameters for
  /// [CustomListTile]s.
  const CustomListTileTheme({
    Key key,
    this.dense = false,
    this.shape,
    this.style = CustomListTileStyle.list,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    Widget child,
  }) : super(key: key, child: child);

  /// Creates a list tile theme that controls the color and style parameters for
  /// [CustomListTile]s, and merges in the current list tile theme, if any.
  ///
  /// The [child] argument must not be null.
  static Widget merge({
    Key key,
    bool dense,
    ShapeBorder shape,
    CustomListTileStyle style,
    Color selectedColor,
    Color iconColor,
    Color textColor,
    EdgeInsetsGeometry contentPadding,
    Color tileColor,
    Color selectedTileColor,
    @required Widget child,
  }) {
    assert(child != null);
    return Builder(
      builder: (BuildContext context) {
        final CustomListTileTheme parent = CustomListTileTheme.of(context);
        return CustomListTileTheme(
          key: key,
          dense: dense ?? parent.dense,
          shape: shape ?? parent.shape,
          style: style ?? parent.style,
          selectedColor: selectedColor ?? parent.selectedColor,
          iconColor: iconColor ?? parent.iconColor,
          textColor: textColor ?? parent.textColor,
          contentPadding: contentPadding ?? parent.contentPadding,
          tileColor: tileColor ?? parent.tileColor,
          selectedTileColor: selectedTileColor ?? parent.selectedTileColor,
          child: child,
        );
      },
    );
  }

  /// If true then [CustomListTile]s will have the vertically dense layout.
  final bool dense;

  /// If specified, [shape] defines the shape of the [CustomListTile]'s [InkWell] border.
  final ShapeBorder shape;

  /// If specified, [style] defines the font used for [CustomListTile] titles.
  final CustomListTileStyle style;

  /// If specified, the color used for icons and text when a [CustomListTile] is selected.
  final Color selectedColor;

  /// If specified, the icon color used for enabled [CustomListTile]s that are not selected.
  final Color iconColor;

  /// If specified, the text color used for enabled [CustomListTile]s that are not selected.
  final Color textColor;

  /// The tile's internal padding.
  ///
  /// Insets a [CustomListTile]'s contents: its [CustomListTile.leading], [CustomListTile.title],
  /// [CustomListTile.subtitle], and [CustomListTile.trailing] widgets.
  final EdgeInsetsGeometry contentPadding;

  /// If specified, defines the background color for `CustomListTile` when
  /// [CustomListTile.selected] is false.
  ///
  /// If [CustomListTile.tileColor] is provided, [tileColor] is ignored.
  final Color tileColor;

  /// If specified, defines the background color for `CustomListTile` when
  /// [CustomListTile.selected] is true.
  ///
  /// If [CustomListTile.selectedTileColor] is provided, [selectedTileColor] is ignored.
  final Color selectedTileColor;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// CustomListTileTheme theme = CustomListTileTheme.of(context);
  /// ```
  static CustomListTileTheme of(BuildContext context) {
    final CustomListTileTheme result = context.dependOnInheritedWidgetOfExactType<CustomListTileTheme>();
    return result ?? const CustomListTileTheme();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final CustomListTileTheme ancestorTheme = context.findAncestorWidgetOfExactType<CustomListTileTheme>();
    return identical(this, ancestorTheme) ? child : CustomListTileTheme(
      dense: dense,
      shape: shape,
      style: style,
      selectedColor: selectedColor,
      iconColor: iconColor,
      textColor: textColor,
      contentPadding: contentPadding,
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(CustomListTileTheme oldWidget) {
    return dense != oldWidget.dense
        || shape != oldWidget.shape
        || style != oldWidget.style
        || selectedColor != oldWidget.selectedColor
        || iconColor != oldWidget.iconColor
        || textColor != oldWidget.textColor
        || contentPadding != oldWidget.contentPadding
        || tileColor != oldWidget.tileColor
        || selectedTileColor != oldWidget.selectedTileColor;
  }
}

/// Where to place the control in widgets that use [CustomListTile] to position a
/// control next to a label.
///
/// See also:
///
///  * [CheckboxCustomListTile], which combines a [CustomListTile] with a [Checkbox].
///  * [RadioCustomListTile], which combines a [CustomListTile] with a [Radio] button.
///  * [SwitchCustomListTile], which combines a [CustomListTile] with a [Switch].
enum CustomListTileControlAffinity {
  /// Position the control on the leading edge, and the secondary widget, if
  /// any, on the trailing edge.
  leading,

  /// Position the control on the trailing edge, and the secondary widget, if
  /// any, on the leading edge.
  trailing,

  /// Position the control relative to the text in the fashion that is typical
  /// for the current platform, and place the secondary widget on the opposite
  /// side.
  platform,
}

/// A single fixed-height row that typically contains some text as well as
/// a leading or trailing icon.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=l8dj0yPBvgQ}
///
/// A list tile contains one to three lines of text optionally flanked by icons or
/// other widgets, such as check boxes. The icons (or other widgets) for the
/// tile are defined with the [leading] and [trailing] parameters. The first
/// line of text is not optional and is specified with [title]. The value of
/// [subtitle], which _is_ optional, will occupy the space allocated for an
/// additional line of text, or two lines if [isThreeLine] is true. If [dense]
/// is true then the overall height of this tile and the size of the
/// [DefaultTextStyle]s that wrap the [title] and [subtitle] widget are reduced.
///
/// It is the responsibility of the caller to ensure that [title] does not wrap,
/// and to ensure that [subtitle] doesn't wrap (if [isThreeLine] is false) or
/// wraps to two lines (if it is true).
///
/// The heights of the [leading] and [trailing] widgets are constrained
/// according to the
/// [Material spec](https://material.io/design/components/lists.html).
/// An exception is made for one-line CustomListTiles for accessibility. Please
/// see the example below to see how to adhere to both Material spec and
/// accessibility requirements.
///
/// Note that [leading] and [trailing] widgets can expand as far as they wish
/// horizontally, so ensure that they are properly constrained.
///
/// List tiles are typically used in [ListView]s, or arranged in [Column]s in
/// [Drawer]s and [Card]s.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// {@tool snippet}
///
/// This example uses a [ListView] to demonstrate different configurations of
/// [CustomListTile]s in [Card]s.
///
/// ![Different variations of CustomListTile](https://flutter.github.io/assets-for-api-docs/assets/material/list_tile.png)
///
/// ```dart
/// ListView(
///   children: const <Widget>[
///     Card(child: CustomListTile(title: Text('One-line CustomListTile'))),
///     Card(
///       child: CustomListTile(
///         leading: FlutterLogo(),
///         title: Text('One-line with leading widget'),
///       ),
///     ),
///     Card(
///       child: CustomListTile(
///         title: Text('One-line with trailing widget'),
///         trailing: Icon(Icons.more_vert),
///       ),
///     ),
///     Card(
///       child: CustomListTile(
///         leading: FlutterLogo(),
///         title: Text('One-line with both widgets'),
///         trailing: Icon(Icons.more_vert),
///       ),
///     ),
///     Card(
///       child: CustomListTile(
///         title: Text('One-line dense CustomListTile'),
///         dense: true,
///       ),
///     ),
///     Card(
///       child: CustomListTile(
///         leading: FlutterLogo(size: 56.0),
///         title: Text('Two-line CustomListTile'),
///         subtitle: Text('Here is a second line'),
///         trailing: Icon(Icons.more_vert),
///       ),
///     ),
///     Card(
///       child: CustomListTile(
///         leading: FlutterLogo(size: 72.0),
///         title: Text('Three-line CustomListTile'),
///         subtitle: Text(
///           'A sufficiently long subtitle warrants three lines.'
///         ),
///         trailing: Icon(Icons.more_vert),
///         isThreeLine: true,
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
/// {@tool snippet}
///
/// Tiles can be much more elaborate. Here is a tile which can be tapped, but
/// which is disabled when the `_act` variable is not 2. When the tile is
/// tapped, the whole row has an ink splash effect (see [InkWell]).
///
/// ```dart
/// int _act = 1;
/// // ...
/// CustomListTile(
///   leading: const Icon(Icons.flight_land),
///   title: const Text("Trix's airplane"),
///   subtitle: _act != 2 ? const Text('The airplane is only in Act II.') : null,
///   enabled: _act == 2,
///   onTap: () { /* react to the tile being tapped */ }
/// )
/// ```
/// {@end-tool}
///
/// To be accessible, tappable [leading] and [trailing] widgets have to
/// be at least 48x48 in size. However, to adhere to the Material spec,
/// [trailing] and [leading] widgets in one-line CustomListTiles should visually be
/// at most 32 ([dense]: true) or 40 ([dense]: false) in height, which may
/// conflict with the accessibility requirement.
///
/// For this reason, a one-line CustomListTile allows the height of [leading]
/// and [trailing] widgets to be constrained by the height of the CustomListTile.
/// This allows for the creation of tappable [leading] and [trailing] widgets
/// that are large enough, but it is up to the developer to ensure that
/// their widgets follow the Material spec.
///
/// {@tool snippet}
///
/// Here is an example of a one-line, non-[dense] CustomListTile with a
/// tappable leading widget that adheres to accessibility requirements and
/// the Material spec. To adjust the use case below for a one-line, [dense]
/// CustomListTile, adjust the vertical padding to 8.0.
///
/// ```dart
/// CustomListTile(
///   leading: GestureDetector(
///     behavior: HitTestBehavior.translucent,
///     onTap: () {},
///     child: Container(
///       width: 48,
///       height: 48,
///       padding: EdgeInsets.symmetric(vertical: 4.0),
///       alignment: Alignment.center,
///       child: CircleAvatar(),
///     ),
///   ),
///   title: Text('title'),
///   dense: false,
/// ),
/// ```
/// {@end-tool}
///
/// ## The CustomListTile layout isn't exactly what I want
///
/// If the way CustomListTile pads and positions its elements isn't quite what
/// you're looking for, it's easy to create custom list items with a
/// combination of other widgets, such as [Row]s and [Column]s.
///
/// {@tool dartpad --template=stateless_widget_scaffold}
///
/// Here is an example of a custom list item that resembles a Youtube related
/// video list item created with [Expanded] and [Container] widgets.
///
/// ![Custom list item a](https://flutter.github.io/assets-for-api-docs/assets/widgets/custom_list_item_a.png)
///
/// ```dart preamble
/// class CustomListItem extends StatelessWidget {
///   const CustomListItem({
///     this.thumbnail,
///     this.title,
///     this.user,
///     this.viewCount,
///   });
///
///   final Widget thumbnail;
///   final String title;
///   final String user;
///   final int viewCount;
///
///   @override
///   Widget build(BuildContext context) {
///     return Padding(
///       padding: const EdgeInsets.symmetric(vertical: 5.0),
///       child: Row(
///         crossAxisAlignment: CrossAxisAlignment.start,
///         children: <Widget>[
///           Expanded(
///             flex: 2,
///             child: thumbnail,
///           ),
///           Expanded(
///             flex: 3,
///             child: _VideoDescription(
///               title: title,
///               user: user,
///               viewCount: viewCount,
///             ),
///           ),
///           const Icon(
///             Icons.more_vert,
///             size: 16.0,
///           ),
///         ],
///       ),
///     );
///   }
/// }
///
/// class _VideoDescription extends StatelessWidget {
///   const _VideoDescription({
///     Key key,
///     this.title,
///     this.user,
///     this.viewCount,
///   }) : super(key: key);
///
///   final String title;
///   final String user;
///   final int viewCount;
///
///   @override
///   Widget build(BuildContext context) {
///     return Padding(
///       padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
///       child: Column(
///         crossAxisAlignment: CrossAxisAlignment.start,
///         children: <Widget>[
///           Text(
///             title,
///             style: const TextStyle(
///               fontWeight: FontWeight.w500,
///               fontSize: 14.0,
///             ),
///           ),
///           const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
///           Text(
///             user,
///             style: const TextStyle(fontSize: 10.0),
///           ),
///           const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
///           Text(
///             '$viewCount views',
///             style: const TextStyle(fontSize: 10.0),
///           ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
///
/// ```dart
/// Widget build(BuildContext context) {
///   return ListView(
///     padding: const EdgeInsets.all(8.0),
///     itemExtent: 106.0,
///     children: <CustomListItem>[
///       CustomListItem(
///         user: 'Flutter',
///         viewCount: 999000,
///         thumbnail: Container(
///           decoration: const BoxDecoration(color: Colors.blue),
///         ),
///         title: 'The Flutter YouTube Channel',
///       ),
///       CustomListItem(
///         user: 'Dash',
///         viewCount: 884000,
///         thumbnail: Container(
///           decoration: const BoxDecoration(color: Colors.yellow),
///         ),
///         title: 'Announcing Flutter 1.0',
///       ),
///     ],
///   );
/// }
/// ```
/// {@end-tool}
///
/// {@tool dartpad --template=stateless_widget_scaffold}
///
/// Here is an example of an article list item with multiline titles and
/// subtitles. It utilizes [Row]s and [Column]s, as well as [Expanded] and
/// [AspectRatio] widgets to organize its layout.
///
/// ![Custom list item b](https://flutter.github.io/assets-for-api-docs/assets/widgets/custom_list_item_b.png)
///
/// ```dart preamble
/// class _ArticleDescription extends StatelessWidget {
///   _ArticleDescription({
///     Key key,
///     this.title,
///     this.subtitle,
///     this.author,
///     this.publishDate,
///     this.readDuration,
///   }) : super(key: key);
///
///   final String title;
///   final String subtitle;
///   final String author;
///   final String publishDate;
///   final String readDuration;
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: <Widget>[
///         Expanded(
///           flex: 1,
///           child: Column(
///             crossAxisAlignment: CrossAxisAlignment.start,
///             children: <Widget>[
///               Text(
///                 '$title',
///                 maxLines: 2,
///                 overflow: TextOverflow.ellipsis,
///                 style: const TextStyle(
///                   fontWeight: FontWeight.bold,
///                 ),
///               ),
///               const Padding(padding: EdgeInsets.only(bottom: 2.0)),
///               Text(
///                 '$subtitle',
///                 maxLines: 2,
///                 overflow: TextOverflow.ellipsis,
///                 style: const TextStyle(
///                   fontSize: 12.0,
///                   color: Colors.black54,
///                 ),
///               ),
///             ],
///           ),
///         ),
///         Expanded(
///           flex: 1,
///           child: Column(
///             crossAxisAlignment: CrossAxisAlignment.start,
///             mainAxisAlignment: MainAxisAlignment.end,
///             children: <Widget>[
///               Text(
///                 '$author',
///                 style: const TextStyle(
///                   fontSize: 12.0,
///                   color: Colors.black87,
///                 ),
///               ),
///               Text(
///                 '$publishDate - $readDuration',
///                 style: const TextStyle(
///                   fontSize: 12.0,
///                   color: Colors.black54,
///                 ),
///               ),
///             ],
///           ),
///         ),
///       ],
///     );
///   }
/// }
///
/// class CustomListItemTwo extends StatelessWidget {
///   CustomListItemTwo({
///     Key key,
///     this.thumbnail,
///     this.title,
///     this.subtitle,
///     this.author,
///     this.publishDate,
///     this.readDuration,
///   }) : super(key: key);
///
///   final Widget thumbnail;
///   final String title;
///   final String subtitle;
///   final String author;
///   final String publishDate;
///   final String readDuration;
///
///   @override
///   Widget build(BuildContext context) {
///     return Padding(
///       padding: const EdgeInsets.symmetric(vertical: 10.0),
///       child: SizedBox(
///         height: 100,
///         child: Row(
///           crossAxisAlignment: CrossAxisAlignment.start,
///           children: <Widget>[
///             AspectRatio(
///               aspectRatio: 1.0,
///               child: thumbnail,
///             ),
///             Expanded(
///               child: Padding(
///                 padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
///                 child: _ArticleDescription(
///                   title: title,
///                   subtitle: subtitle,
///                   author: author,
///                   publishDate: publishDate,
///                   readDuration: readDuration,
///                 ),
///               ),
///             )
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// ```dart
/// Widget build(BuildContext context) {
///   return ListView(
///     padding: const EdgeInsets.all(10.0),
///     children: <Widget>[
///       CustomListItemTwo(
///         thumbnail: Container(
///           decoration: const BoxDecoration(color: Colors.pink),
///         ),
///         title: 'Flutter 1.0 Launch',
///         subtitle:
///           'Flutter continues to improve and expand its horizons.'
///           'This text should max out at two lines and clip',
///         author: 'Dash',
///         publishDate: 'Dec 28',
///         readDuration: '5 mins',
///       ),
///       CustomListItemTwo(
///         thumbnail: Container(
///           decoration: const BoxDecoration(color: Colors.blue),
///         ),
///         title: 'Flutter 1.2 Release - Continual updates to the framework',
///         subtitle: 'Flutter once again improves and makes updates.',
///         author: 'Flutter',
///         publishDate: 'Feb 26',
///         readDuration: '12 mins',
///       ),
///     ],
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomListTileTheme], which defines visual properties for [CustomListTile]s.
///  * [ListView], which can display an arbitrary number of [CustomListTile]s
///    in a scrolling list.
///  * [CircleAvatar], which shows an icon representing a person and is often
///    used as the [leading] element of a CustomListTile.
///  * [Card], which can be used with [Column] to show a few [CustomListTile]s.
///  * [Divider], which can be used to separate [CustomListTile]s.
///  * [CustomListTile.divideTiles], a utility for inserting [Divider]s in between [CustomListTile]s.
///  * [CheckboxCustomListTile], [RadioCustomListTile], and [SwitchCustomListTile], widgets
///    that combine [CustomListTile] with other controls.
///  * <https://material.io/design/components/lists.html>
///  * Cookbook: [Use lists](https://flutter.dev/docs/cookbook/lists/basic-list)
///  * Cookbook: [Implement swipe to dismiss](https://flutter.dev/docs/cookbook/gestures/dismissible)
class CustomListTile extends StatelessWidget {
  /// Creates a list tile.
  ///
  /// If [isThreeLine] is true, then [subtitle] must not be null.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const CustomListTile({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.visualDensity,
    this.shape,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
  }) : assert(isThreeLine != null),
       assert(enabled != null),
       assert(selected != null),
       assert(autofocus != null),
       assert(!isThreeLine || subtitle != null),
       super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget leading;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  ///
  /// This should not wrap. To enforce the single line limit, use
  /// [Text.maxLines].
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  ///
  /// If [isThreeLine] is false, this should not wrap.
  ///
  /// If [isThreeLine] is true, this should be configured to take a maximum of
  /// two lines. For example, you can use [Text.maxLines] to enforce the number
  /// of lines.
  ///
  /// The subtitle's default [TextStyle] depends on [TextTheme.bodyText2] except
  /// [TextStyle.color]. The [TextStyle.color] depends on the value of [enabled]
  /// and [selected].
  ///
  /// When [enabled] is false, the text color is set to [ThemeData.disabledColor].
  ///
  /// When [selected] is true, the text color is set to [CustomListTileTheme.selectedColor]
  /// if it's not null. If [CustomListTileTheme.selectedColor] is null, the text color
  /// is set to [ThemeData.primaryColor] when [ThemeData.brightness] is
  /// [Brightness.light] and to [ThemeData.accentColor] when it is [Brightness.dark].
  ///
  /// When [selected] is false, the text color is set to [CustomListTileTheme.textColor]
  /// if it's not null and to [TextTheme.caption]'s color if [CustomListTileTheme.textColor]
  /// is null.
  final Widget subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [CrossAxisAlignment.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget trailing;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If true, then [subtitle] must be non-null (since it is expected to give
  /// the second and third lines of text).
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  ///
  /// When using a [Text] widget for [title] and [subtitle], you can enforce
  /// line limits using [Text.maxLines].
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [CustomListTileTheme.dense].
  ///
  /// Dense list tiles default to a smaller height.
  final bool dense;

  /// Defines how compact the list tile's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
  ///    widgets within a [Theme].
  final VisualDensity visualDensity;

  /// The shape of the tile's [InkWell].
  ///
  /// Defines the tile's [InkWell.customBorder].
  ///
  /// If this property is null then [CardTheme.shape] of [ThemeData.cardTheme]
  /// is used. If that's null then the shape will be a [RoundedRectangleBorder]
  /// with a circular corner radius of 4.0.
  final ShapeBorder shape;

  /// The tile's internal padding.
  ///
  /// Insets a [CustomListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry contentPadding;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback onTap;

  /// Called when the user long-presses on this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureLongPressCallback onLongPress;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor mouseCursor;

  /// If this tile is also [enabled] then icons and text are rendered with the same color.
  ///
  /// By default the selected color is the theme's primary color. The selected color
  /// can be overridden with a [CustomListTileTheme].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  ///
  /// Here is an example of using a [StatefulWidget] to keep track of the
  /// selected index, and using that to set the `selected` property on the
  /// corresponding [CustomListTile].
  ///
  /// ```dart
  ///   int _selectedIndex;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return ListView.builder(
  ///       itemCount: 10,
  ///       itemBuilder: (BuildContext context, int index) {
  ///         return CustomListTile(
  ///           title: Text('Item $index'),
  ///           selected: index == _selectedIndex,
  ///           onTap: () {
  ///             setState(() {
  ///               _selectedIndex = index;
  ///             });
  ///           },
  ///         );
  ///       },
  ///     );
  ///   }
  /// ```
  /// {@end-tool}
  final bool selected;

  /// The color for the tile's [Material] when it has the input focus.
  final Color focusColor;

  /// The color for the tile's [Material] when a pointer is hovering over it.
  final Color hoverColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Defines the background color of `CustomListTile` when [selected] is false.
  ///
  /// When the value is null, the `tileColor` is set to [CustomListTileTheme.tileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  final Color tileColor;

  /// Defines the background color of `CustomListTile` when [selected] is true.
  ///
  /// When the value if null, the `selectedTileColor` is set to [CustomListTileTheme.selectedTileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  final Color selectedTileColor;

  /// Add a one pixel border in between each tile. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used.
  ///
  /// See also:
  ///
  ///  * [Divider], which you can use to obtain this effect manually.
  static Iterable<Widget> divideTiles({ BuildContext context, @required Iterable<Widget> tiles, Color color }) sync* {
    assert(tiles != null);
    assert(color != null || context != null);

    final Iterator<Widget> iterator = tiles.iterator;
    final bool isNotEmpty = iterator.moveNext();

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context, color: color),
      ),
    );

    Widget tile = iterator.current;
    while (iterator.moveNext()) {
      yield DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: decoration,
        child: tile,
      );
      tile = iterator.current;
    }
    if (isNotEmpty)
      yield tile;
  }

  Color _iconColor(ThemeData theme, CustomListTileTheme tileTheme) {
    if (!enabled)
      return theme.disabledColor;

    if (selected && tileTheme?.selectedColor != null)
      return tileTheme.selectedColor;

    if (!selected && tileTheme?.iconColor != null)
      return tileTheme.iconColor;

    switch (theme.brightness) {
      case Brightness.light:
        return selected ? theme.primaryColor : Colors.black45;
      case Brightness.dark:
        return selected ? theme.accentColor : null; // null - use current icon theme color
    }
    assert(theme.brightness != null);
    return null;
  }

  Color _textColor(ThemeData theme, CustomListTileTheme tileTheme, Color defaultColor) {
    if (!enabled)
      return theme.disabledColor;

    if (selected && tileTheme?.selectedColor != null)
      return tileTheme.selectedColor;

    if (!selected && tileTheme?.textColor != null)
      return tileTheme.textColor;

    if (selected) {
      switch (theme.brightness) {
        case Brightness.light:
          return theme.primaryColor;
        case Brightness.dark:
          return theme.accentColor;
      }
    }
    return defaultColor;
  }

  bool _isDenseLayout(CustomListTileTheme tileTheme) {
    return dense ?? tileTheme?.dense ?? false;
  }

  TextStyle _titleTextStyle(ThemeData theme, CustomListTileTheme tileTheme) {
    TextStyle style;
    if (tileTheme != null) {
      switch (tileTheme.style) {
        case CustomListTileStyle.drawer:
          style = theme.textTheme.bodyText1;
          break;
        case CustomListTileStyle.list:
          style = theme.textTheme.subtitle1;
          break;
      }
    } else {
      style = theme.textTheme.subtitle1;
    }
    final Color color = _textColor(theme, tileTheme, style.color);
    return _isDenseLayout(tileTheme)
      ? style.copyWith(fontSize: 13.0, color: color)
      : style.copyWith(color: color);
  }

  TextStyle _subtitleTextStyle(ThemeData theme, CustomListTileTheme tileTheme) {
    final TextStyle style = theme.textTheme.bodyText2;
    final Color color = _textColor(theme, tileTheme, theme.textTheme.caption.color);
    return _isDenseLayout(tileTheme)
      ? style.copyWith(color: color, fontSize: 12.0)
      : style.copyWith(color: color);
  }

  Color _tileBackgroundColor(CustomListTileTheme tileTheme) {
    if (!selected) {
      if (tileColor != null)
        return tileColor;
      if (tileTheme?.tileColor != null)
        return tileTheme.tileColor;
    }

    if (selected) {
      if (selectedTileColor != null)
        return selectedTileColor;
      if (tileTheme?.selectedTileColor != null)
        return tileTheme.selectedTileColor;
    }

    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final CustomListTileTheme tileTheme = CustomListTileTheme.of(context);

    IconThemeData iconThemeData;
    if (leading != null || trailing != null)
      iconThemeData = IconThemeData(color: _iconColor(theme, tileTheme));

    Widget leadingIcon;
    if (leading != null) {
      leadingIcon = IconTheme.merge(
        data: iconThemeData,
        child: leading,
      );
    }

    final TextStyle titleStyle = _titleTextStyle(theme, tileTheme);
    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: title ?? const SizedBox(),
    );

    Widget subtitleText;
    TextStyle subtitleStyle;
    if (subtitle != null) {
      subtitleStyle = _subtitleTextStyle(theme, tileTheme);
      subtitleText = AnimatedDefaultTextStyle(
        style: subtitleStyle,
        duration: kThemeChangeDuration,
        child: subtitle,
      );
    }

    Widget trailingIcon;
    if (trailing != null) {
      trailingIcon = IconTheme.merge(
        data: iconThemeData,
        child: trailing,
      );
    }

    const EdgeInsets _defaultContentPadding = EdgeInsets.symmetric(horizontal: 16.0);
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding = contentPadding?.resolve(textDirection)
      ?? tileTheme?.contentPadding?.resolve(textDirection)
      ?? _defaultContentPadding;

    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!enabled || (onTap == null && onLongPress == null)) MaterialState.disabled,
        if (selected) MaterialState.selected,
      },
    );

    return InkWell(
      customBorder: shape ?? tileTheme.shape,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      mouseCursor: effectiveMouseCursor,
      canRequestFocus: enabled,
      focusNode: focusNode,
      focusColor: focusColor,
      hoverColor: hoverColor,
      autofocus: autofocus,
      child: Semantics(
        selected: selected,
        enabled: enabled,
        child: ColoredBox(
          color: _tileBackgroundColor(tileTheme),
          child: SafeArea(
            top: false,
            bottom: false,
            minimum: resolvedContentPadding,
            child: _CustomListTile(
              leading: leadingIcon,
              title: titleText,
              subtitle: subtitleText,
              trailing: trailingIcon,
              isDense: _isDenseLayout(tileTheme),
              visualDensity: visualDensity ?? theme.visualDensity,
              isThreeLine: isThreeLine,
              textDirection: textDirection,
              titleBaselineType: titleStyle.textBaseline,
              subtitleBaselineType: subtitleStyle?.textBaseline,
            ),
          ),
        ),
      ),
    );
  }
}

// Identifies the children of a _CustomListTileElement.
enum _CustomListTileSlot {
  leading,
  title,
  subtitle,
  trailing,
}

class _CustomListTile extends RenderObjectWidget {
  const _CustomListTile({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    @required this.isThreeLine,
    @required this.isDense,
    @required this.visualDensity,
    @required this.textDirection,
    @required this.titleBaselineType,
    this.subtitleBaselineType,
  }) : assert(isThreeLine != null),
       assert(isDense != null),
       assert(visualDensity != null),
       assert(textDirection != null),
       assert(titleBaselineType != null),
       super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final bool isThreeLine;
  final bool isDense;
  final VisualDensity visualDensity;
  final TextDirection textDirection;
  final TextBaseline titleBaselineType;
  final TextBaseline subtitleBaselineType;

  @override
  _CustomListTileElement createElement() => _CustomListTileElement(this);

  @override
  _RenderCustomListTile createRenderObject(BuildContext context) {
    return _RenderCustomListTile(
      isThreeLine: isThreeLine,
      isDense: isDense,
      visualDensity: visualDensity,
      textDirection: textDirection,
      titleBaselineType: titleBaselineType,
      subtitleBaselineType: subtitleBaselineType,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderCustomListTile renderObject) {
    renderObject
      ..isThreeLine = isThreeLine
      ..isDense = isDense
      ..visualDensity = visualDensity
      ..textDirection = textDirection
      ..titleBaselineType = titleBaselineType
      ..subtitleBaselineType = subtitleBaselineType;
  }
}

class _CustomListTileElement extends RenderObjectElement {
  _CustomListTileElement(_CustomListTile widget) : super(widget);

  final Map<_CustomListTileSlot, Element> slotToChild = <_CustomListTileSlot, Element>{};

  @override
  _CustomListTile get widget => super.widget as _CustomListTile;

  @override
  _RenderCustomListTile get renderObject => super.renderObject as _RenderCustomListTile;

  @override
  void visitChildren(ElementVisitor visitor) {
    slotToChild.values.forEach(visitor);
  }

  @override
  void forgetChild(Element child) {
    assert(slotToChild.containsValue(child));
    assert(child.slot is _CustomListTileSlot);
    assert(slotToChild.containsKey(child.slot));
    slotToChild.remove(child.slot);
    super.forgetChild(child);
  }

  void _mountChild(Widget widget, _CustomListTileSlot slot) {
    final Element oldChild = slotToChild[slot];
    final Element newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      slotToChild.remove(slot);
    }
    if (newChild != null) {
      slotToChild[slot] = newChild;
    }
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _mountChild(widget.leading, _CustomListTileSlot.leading);
    _mountChild(widget.title, _CustomListTileSlot.title);
    _mountChild(widget.subtitle, _CustomListTileSlot.subtitle);
    _mountChild(widget.trailing, _CustomListTileSlot.trailing);
  }

  void _updateChild(Widget widget, _CustomListTileSlot slot) {
    final Element oldChild = slotToChild[slot];
    final Element newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      slotToChild.remove(slot);
    }
    if (newChild != null) {
      slotToChild[slot] = newChild;
    }
  }

  @override
  void update(_CustomListTile newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _updateChild(widget.leading, _CustomListTileSlot.leading);
    _updateChild(widget.title, _CustomListTileSlot.title);
    _updateChild(widget.subtitle, _CustomListTileSlot.subtitle);
    _updateChild(widget.trailing, _CustomListTileSlot.trailing);
  }

  void _updateRenderObject(RenderBox child, _CustomListTileSlot slot) {
    switch (slot) {
      case _CustomListTileSlot.leading:
        renderObject.leading = child;
        break;
      case _CustomListTileSlot.title:
        renderObject.title = child;
        break;
      case _CustomListTileSlot.subtitle:
        renderObject.subtitle = child;
        break;
      case _CustomListTileSlot.trailing:
        renderObject.trailing = child;
        break;
    }
  }

  @override
  void insertRenderObjectChild(RenderObject child, _CustomListTileSlot slot) {
    assert(child is RenderBox);
    _updateRenderObject(child as RenderBox, slot);
    assert(renderObject.children.keys.contains(slot));
  }

  @override
  void removeRenderObjectChild(RenderObject child, _CustomListTileSlot slot) {
    assert(child is RenderBox);
    assert(renderObject.children[slot] == child);
    _updateRenderObject(null, slot);
    assert(!renderObject.children.keys.contains(slot));
  }

  @override
  void moveRenderObjectChild(RenderObject child, dynamic oldSlot, dynamic newSlot) {
    assert(false, 'not reachable');
  }
}

class _RenderCustomListTile extends RenderBox {
  _RenderCustomListTile({
    @required bool isDense,
    @required VisualDensity visualDensity,
    @required bool isThreeLine,
    @required TextDirection textDirection,
    @required TextBaseline titleBaselineType,
    TextBaseline subtitleBaselineType,
  }) : assert(isDense != null),
       assert(visualDensity != null),
       assert(isThreeLine != null),
       assert(textDirection != null),
       assert(titleBaselineType != null),
       _isDense = isDense,
       _visualDensity = visualDensity,
       _isThreeLine = isThreeLine,
       _textDirection = textDirection,
       _titleBaselineType = titleBaselineType,
       _subtitleBaselineType = subtitleBaselineType;

  static const double _minLeadingWidth = 0.0;
  // The horizontal gap between the titles and the leading/trailing widgets
  double get _horizontalTitleGap => 16.0 + visualDensity.horizontal * 2.0;
  // The minimum padding on the top and bottom of the title and subtitle widgets.
  static const double _minVerticalPadding = 0.0;

  final Map<_CustomListTileSlot, RenderBox> children = <_CustomListTileSlot, RenderBox>{};

  RenderBox _updateChild(RenderBox oldChild, RenderBox newChild, _CustomListTileSlot slot) {
    if (oldChild != null) {
      dropChild(oldChild);
      children.remove(slot);
    }
    if (newChild != null) {
      children[slot] = newChild;
      adoptChild(newChild);
    }
    return newChild;
  }

  RenderBox _leading;
  RenderBox get leading => _leading;
  set leading(RenderBox value) {
    _leading = _updateChild(_leading, value, _CustomListTileSlot.leading);
  }

  RenderBox _title;
  RenderBox get title => _title;
  set title(RenderBox value) {
    _title = _updateChild(_title, value, _CustomListTileSlot.title);
  }

  RenderBox _subtitle;
  RenderBox get subtitle => _subtitle;
  set subtitle(RenderBox value) {
    _subtitle = _updateChild(_subtitle, value, _CustomListTileSlot.subtitle);
  }

  RenderBox _trailing;
  RenderBox get trailing => _trailing;
  set trailing(RenderBox value) {
    _trailing = _updateChild(_trailing, value, _CustomListTileSlot.trailing);
  }

  // The returned list is ordered for hit testing.
  Iterable<RenderBox> get _children sync* {
    if (leading != null)
      yield leading;
    if (title != null)
      yield title;
    if (subtitle != null)
      yield subtitle;
    if (trailing != null)
      yield trailing;
  }

  bool get isDense => _isDense;
  bool _isDense;
  set isDense(bool value) {
    assert(value != null);
    if (_isDense == value)
      return;
    _isDense = value;
    markNeedsLayout();
  }

  VisualDensity get visualDensity => _visualDensity;
  VisualDensity _visualDensity;
  set visualDensity(VisualDensity value) {
    assert(value != null);
    if (_visualDensity == value)
      return;
    _visualDensity = value;
    markNeedsLayout();
  }

  bool get isThreeLine => _isThreeLine;
  bool _isThreeLine;
  set isThreeLine(bool value) {
    assert(value != null);
    if (_isThreeLine == value)
      return;
    _isThreeLine = value;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value)
      return;
    _textDirection = value;
    markNeedsLayout();
  }

  TextBaseline get titleBaselineType => _titleBaselineType;
  TextBaseline _titleBaselineType;
  set titleBaselineType(TextBaseline value) {
    assert(value != null);
    if (_titleBaselineType == value)
      return;
    _titleBaselineType = value;
    markNeedsLayout();
  }

  TextBaseline get subtitleBaselineType => _subtitleBaselineType;
  TextBaseline _subtitleBaselineType;
  set subtitleBaselineType(TextBaseline value) {
    if (_subtitleBaselineType == value)
      return;
    _subtitleBaselineType = value;
    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    for (final RenderBox child in _children)
      child.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    for (final RenderBox child in _children)
      child.detach();
  }

  @override
  void redepthChildren() {
    _children.forEach(redepthChild);
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    _children.forEach(visitor);
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> value = <DiagnosticsNode>[];
    void add(RenderBox child, String name) {
      if (child != null)
        value.add(child.toDiagnosticsNode(name: name));
    }
    add(leading, 'leading');
    add(title, 'title');
    add(subtitle, 'subtitle');
    add(trailing, 'trailing');
    return value;
  }

  @override
  bool get sizedByParent => false;

  static double _minWidth(RenderBox box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
      ? math.max(leading.getMinIntrinsicWidth(height), _minLeadingWidth) + _horizontalTitleGap
      : 0.0;
    return leadingWidth
      + math.max(_minWidth(title, height), _minWidth(subtitle, height))
      + _maxWidth(trailing, height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
      ? math.max(leading.getMaxIntrinsicWidth(height), _minLeadingWidth) + _horizontalTitleGap
      : 0.0;
    return leadingWidth
      + math.max(_maxWidth(title, height), _maxWidth(subtitle, height))
      + _maxWidth(trailing, height);
  }

  double get _defaultTileHeight {
    final bool hasSubtitle = subtitle != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;

    final Offset baseDensity = visualDensity.baseSizeAdjustment;
    if (isOneLine)
      return (isDense ? 40.0 : 48.0) + baseDensity.dy;
    if (isTwoLine)
      return (isDense ? 56.0 : 64.0) + baseDensity.dy;
    return (isDense ? 68.0 : 80.0) + baseDensity.dy;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return math.max(
      _defaultTileHeight,
      title.getMinIntrinsicHeight(width) + (subtitle?.getMinIntrinsicHeight(width) ?? 0.0),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    assert(title != null);
    final BoxParentData parentData = title.parentData as BoxParentData;
    return parentData.offset.dy + title.getDistanceToActualBaseline(baseline);
  }

  static double _boxBaseline(RenderBox box, TextBaseline baseline) {
    return box.getDistanceToBaseline(baseline);
  }

  static Size _layoutBox(RenderBox box, BoxConstraints constraints) {
    if (box == null)
      return Size.zero;
    box.layout(constraints, parentUsesSize: true);
    return box.size;
  }

  static void _positionBox(RenderBox box, Offset offset) {
    final BoxParentData parentData = box.parentData as BoxParentData;
    parentData.offset = offset;
  }

  // All of the dimensions below were taken from the Material Design spec:
  // https://material.io/design/components/lists.html#specs
  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final bool hasLeading = leading != null;
    final bool hasSubtitle = subtitle != null;
    final bool hasTrailing = trailing != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;
    final Offset densityAdjustment = visualDensity.baseSizeAdjustment;

    final BoxConstraints maxIconHeightConstraint = BoxConstraints(
      // One-line trailing and leading widget heights do not follow
      // Material specifications, but this sizing is required to adhere
      // to accessibility requirements for smallest tappable widget.
      // Two- and three-line trailing widget heights are constrained
      // properly according to the Material spec.
      maxHeight: (isDense ? 48.0 : 56.0) + densityAdjustment.dy,
    );
    final BoxConstraints looseConstraints = constraints.loosen();
    final BoxConstraints iconConstraints = looseConstraints.enforce(maxIconHeightConstraint);

    final double tileWidth = looseConstraints.maxWidth;
    final Size leadingSize = _layoutBox(leading, iconConstraints);
    final Size trailingSize = _layoutBox(trailing, iconConstraints);
    assert(
      tileWidth != leadingSize.width,
      'Leading widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing CustomListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/CustomListTile-class.html#material.CustomListTile.4)'
    );
    assert(
      tileWidth != trailingSize.width,
      'Trailing widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing CustomListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/CustomListTile-class.html#material.CustomListTile.4)'
    );

    final double titleStart = hasLeading
      ? math.max(_minLeadingWidth, leadingSize.width) + _horizontalTitleGap
      : 0.0;
    final double adjustedTrailingWidth = hasTrailing
        ? math.max(trailingSize.width + _horizontalTitleGap, 32.0)
        : 0.0;
    final BoxConstraints textConstraints = looseConstraints.tighten(
      width: tileWidth - titleStart - adjustedTrailingWidth,
    );
    final Size titleSize = _layoutBox(title, textConstraints);
    final Size subtitleSize = _layoutBox(subtitle, textConstraints);

    double titleBaseline;
    double subtitleBaseline;
    if (isTwoLine) {
      titleBaseline = isDense ? 28.0 : 32.0;
      subtitleBaseline = isDense ? 48.0 : 52.0;
    } else if (isThreeLine) {
      titleBaseline = isDense ? 22.0 : 28.0;
      subtitleBaseline = isDense ? 42.0 : 48.0;
    } else {
      assert(isOneLine);
    }

    final double defaultTileHeight = _defaultTileHeight;

    double tileHeight;
    double titleY;
    double subtitleY;
    if (!hasSubtitle) {
      tileHeight = math.max(defaultTileHeight, titleSize.height + 2.0 * _minVerticalPadding);
      titleY = (tileHeight - titleSize.height) / 2.0;
    } else {
      assert(subtitleBaselineType != null);
      titleY = titleBaseline - _boxBaseline(title, titleBaselineType);
      subtitleY = subtitleBaseline - _boxBaseline(subtitle, subtitleBaselineType) + visualDensity.vertical * 2.0;
      tileHeight = defaultTileHeight;

      // If the title and subtitle overlap, move the title upwards by half
      // the overlap and the subtitle down by the same amount, and adjust
      // tileHeight so that both titles fit.
      final double titleOverlap = titleY + titleSize.height - subtitleY;
      if (titleOverlap > 0.0) {
        titleY -= titleOverlap / 2.0;
        subtitleY += titleOverlap / 2.0;
      }

      // If the title or subtitle overflow tileHeight then punt: title
      // and subtitle are arranged in a column, tileHeight = column height plus
      // _minVerticalPadding on top and bottom.
      if (titleY < _minVerticalPadding ||
          (subtitleY + subtitleSize.height + _minVerticalPadding) > tileHeight) {
        tileHeight = titleSize.height + subtitleSize.height + 2.0 * _minVerticalPadding;
        titleY = _minVerticalPadding;
        subtitleY = titleSize.height + _minVerticalPadding;
      }
    }

    // This attempts to implement the redlines for the vertical position of the
    // leading and trailing icons on the spec page:
    //   https://material.io/design/components/lists.html#specs
    // The interpretation for these redlines is as follows:
    //  - For large tiles (> 72dp), both leading and trailing controls should be
    //    a fixed distance from top. As per guidelines this is set to 16dp.
    //  - For smaller tiles, trailing should always be centered. Leading can be
    //    centered or closer to the top. It should never be further than 16dp
    //    to the top.
    double leadingY;
    double trailingY;
    if (tileHeight > 72.0) {
      leadingY = 16.0;
      trailingY = 16.0;
    } else {
      leadingY = math.min((tileHeight - leadingSize.height) / 2.0, 16.0);
      trailingY = (tileHeight - trailingSize.height) / 2.0;
    }

    switch (textDirection) {
      case TextDirection.rtl: {
        if (hasLeading)
          _positionBox(leading, Offset(tileWidth - leadingSize.width, leadingY));
        _positionBox(title, Offset(adjustedTrailingWidth, titleY));
        if (hasSubtitle)
          _positionBox(subtitle, Offset(adjustedTrailingWidth, subtitleY));
        if (hasTrailing)
          _positionBox(trailing, Offset(0.0, trailingY));
        break;
      }
      case TextDirection.ltr: {
        if (hasLeading)
          _positionBox(leading, Offset(0.0, leadingY));
        _positionBox(title, Offset(titleStart, titleY));
        if (hasSubtitle)
          _positionBox(subtitle, Offset(titleStart, subtitleY));
        if (hasTrailing)
          _positionBox(trailing, Offset(tileWidth - trailingSize.width, trailingY));
        break;
      }
    }

    size = constraints.constrain(Size(tileWidth, tileHeight));
    assert(size.width == constraints.constrainWidth(tileWidth));
    assert(size.height == constraints.constrainHeight(tileHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox child) {
      if (child != null) {
        final BoxParentData parentData = child.parentData as BoxParentData;
        context.paintChild(child, parentData.offset + offset);
      }
    }
    doPaint(leading);
    doPaint(title);
    doPaint(subtitle);
    doPaint(trailing);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, { @required Offset position }) {
    assert(position != null);
    for (final RenderBox child in _children) {
      final BoxParentData parentData = child.parentData as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - parentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit)
        return true;
    }
    return false;
  }
}
