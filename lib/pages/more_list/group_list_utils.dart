
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/pages/more_list/two_level_widget.dart';

import 'list_model.dart';


class GroupListView<T extends BaseBean> extends StatefulWidget {

  ///Function which returns the number of items(rows) in a specified section.
  final int Function(int section) countOfItemInSection;

  final Axis scrollDirection;

  final bool reverse;

  final ScrollController? controller;

  final bool? primary;

  final ScrollPhysics? physics;

  final bool shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;


  final double? itemExtent;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool addSemanticIndexes;

  final double? cacheExtent;

  final int? semanticChildCount;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;
  final GroupChildViewCreate? groupChildViewCreate;
  final List<T> data;
  final SectionViewCreate sectionViewCreate;

  const GroupListView({
    Key? key,
    required this.countOfItemInSection,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.groupChildViewCreate,
    required this.data,
    required this.sectionViewCreate
  })  :assert(data != null),
        assert(countOfItemInSection != null),
        super(key: key);

  @override
  _GroupListViewState createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      itemExtent: widget.itemExtent,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      cacheExtent: widget.cacheExtent,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior,
      itemCount: widget.data.length,
      itemBuilder: _itemBuilder,
    );

  }


  Widget _itemBuilder(BuildContext context, int index) {
    return  TwoLevelWidget(widget.groupChildViewCreate!,widget.sectionViewCreate,widget.data[index]);
  }
}