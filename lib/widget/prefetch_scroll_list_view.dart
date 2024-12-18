import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PrefetchScrollListViewController<T> extends ChangeNotifier {
  int _pageIndex = 1;
  int _pageSize = 20;
  bool hasNextPage = true;
  // 还剩下多少元素未滚动时就触发预加载
  int prefetchThreshold;
  bool isLoading = false;
  final List<T> _items = [];

  Future<List<T>> Function(int pageIndex, int pageSize) dataProvider;

  PrefetchScrollListViewController({
    required this.dataProvider,
    this.prefetchThreshold = 10,
  });

  void onScroll(ScrollPosition position) {
    var maxScrollExtent = position.maxScrollExtent;
    var currentScroll = position.pixels;

    if (maxScrollExtent - currentScroll < prefetchThreshold * _itemHeight()) {
      loadNextPage();
    }
  }

  Future<void> loadNextPage() async {
    if (!hasNextPage || isLoading) {
      return;
    }

    isLoading = true;

    try {
      List<T> data = await dataProvider(_pageIndex, _pageSize);
      if (data.isEmpty) {
        hasNextPage = false;
      } else {
        _items.addAll(data);
        _pageIndex++;
      }
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  void refresh() async {
    _pageIndex = 1;
    _items.clear();
    hasNextPage = true;

    await loadNextPage();
  }

  T? itemAt(int index) {
    if (index < _items.length) {
      return _items[index];
    }

    return null;
  }

  // TODO 获取构建出来的listTile的高度
  double _itemHeight() {
    return 80;
  }
}

class PrefetchScrollListView<T> extends StatefulWidget {
  final PrefetchScrollListViewController<T> _controller;
  final Widget Function(T item) _itemBuilder;

  const PrefetchScrollListView(this._controller, this._itemBuilder, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PrefetchScrollListViewState(_controller, _itemBuilder);
  }
}

class _PrefetchScrollListViewState<T> extends State<PrefetchScrollListView> {
  final ScrollController _scrollController = ScrollController();
  final PrefetchScrollListViewController<T> _controller;
  final Widget Function(T item) _itemBuilder;

  _PrefetchScrollListViewState(this._controller, this._itemBuilder);

  @override
  void initState() {
    super.initState();

    _controller.loadNextPage();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey.withAlpha(50),
                height: 2,
                thickness: 2,
              );
            },
            controller: _scrollController,
            itemCount: _controller._items.length + (_controller.hasNextPage ? 1 : 0),
            itemBuilder: (context, index) {
              T? item = _controller.itemAt(index);
              if (item != null) {
                return _itemBuilder(item);
              } else {
                return null;
              }
            },
          );
        },
      )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _controller.onScroll(_scrollController.position);
  }
}