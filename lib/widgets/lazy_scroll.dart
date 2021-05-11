import 'package:flutter/material.dart';

class LazyScroll extends StatefulWidget {
  final LazyScrollBuilder builder;
  final int extent;
  final Function loadMore; //return true to finish

  LazyScroll({
    @required this.builder,
    @required this.loadMore,
    this.extent = 500,
  });

  @override
  _LazyScrollState createState() => _LazyScrollState();
}

class _LazyScrollState extends State<LazyScroll> {
  ScrollController _controller;
  bool _fetching;
  bool _finished;

  @override
  void initState() {
    super.initState();
    _fetching = false;
    _finished = false;
    _controller = new ScrollController()..addListener(scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMore();
  }

  void scrollListener() async {
    if (_controller.position.extentAfter < widget.extent) fetchMore();
  }

  void fetchMore() async {
    if (!_fetching && !_finished) {
      _fetching = true;
      if ((await widget.loadMore()) ?? false) {
        _finished = true;
      }
      _fetching = false;
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller);
  }
}

typedef LazyScrollBuilder = Widget Function(
    BuildContext context, ScrollController controller);
