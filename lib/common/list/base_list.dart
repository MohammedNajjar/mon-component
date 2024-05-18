import 'dart:async';

import 'package:mon/common/base_stateful_widget.dart';
import 'package:mon/common/base_text.dart';
import 'package:mon/common/list/base_list_data.dart';
import 'package:mon/model/base_response.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:mon/utils/libs/pull_to_refresh/indicator/classic_indicator.dart';
import 'package:mon/utils/libs/pull_to_refresh/smart_refresher.dart';
import 'package:mon/web_service/base_request.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SelectionType { none, single, multi, toggle }

enum GeneralAction { updateSelection, clearSelection, fetchData }

enum ListType { list, grid }

typedef BaseFunctions = Map<GeneralAction, Function>;

class GeneralList extends MBStatefulWidget {
  static String get id {
    const Type type = GeneralList;
    return '$type';
  }

  final bool showErrorMessage;
  final bool isPullToRefreshEnabled;
  final bool isLoadMoreEnabled;
  final bool isShowingEmptyState;
  final SelectionType selectionType;
  final ListType listType;
  final int? pageSize;
  final String? emptyStateTitle;
  final String? emptyStateImage;
  final Widget? emptyState;
  final RequestBuilder? requestBuilder;
  final SliverGridDelegate? gridDelegate;
  final Widget? Function(BuildContext context, BaseListData object, int index)
      itemBuilder;
  final void Function(BaseListData object, int index)? onItemTap;
  final void Function(BaseFunctions functions)? setFunctions;
  final BaseRequest? Function()? setRequest;
  final Future<List<dynamic>>? Function(BaseResponse? response)? responseHandler;
  final BaseListData Function(dynamic object, int index)? handlingSelection;
  final Future<List<BaseListData>> Function()? setObjects;
  final void Function(List<dynamic> objects)? getSelectedObjects;
  final Future<List<dynamic>?> Function()? setData;

  const GeneralList({
    Key? key,
    required this.itemBuilder,
    this.showErrorMessage = false,
    this.isPullToRefreshEnabled = false,
    this.isLoadMoreEnabled = false,
    this.isShowingEmptyState = false,
    this.pageSize = Constants.pageSize,
    this.selectionType = SelectionType.none,
    this.listType = ListType.list,
    this.gridDelegate,
    this.setFunctions,
    this.emptyStateTitle,
    this.emptyStateImage,
    this.responseHandler,
    this.handlingSelection,
    this.requestBuilder,
    this.getSelectedObjects,
    this.setObjects,
    this.setRequest,
    this.emptyState,
    this.onItemTap,
    this.setData,
  }) : super(key: key);

  @override
  MBState<GeneralList> createState() => _GeneralListState();
}

class _GeneralListState extends MBState<GeneralList> {
  bool isFetchingDataForFirstTime = false;
  int currentPage = 1;
  int totalItems = 1;
  BaseRequest? _request;
  List<BaseListData> _list = [];
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.setRequest != null) {
      isFetchingDataForFirstTime = true;
    }
    _fetchData();
    if (widget.setFunctions != null) {
      widget.setFunctions!({
        GeneralAction.fetchData: refetchData,
        GeneralAction.updateSelection: updateSelection,
        GeneralAction.clearSelection: clearSelection
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Logger.log("rebuild widget");
    return SmartRefresher(
      onRefresh: _onRefresh,
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      physics: const BouncingScrollPhysics(),
      enablePullUp: widget.isLoadMoreEnabled,
      enablePullDown: widget.isPullToRefreshEnabled,
      onLoading: _onLoadMore,
      controller: _refreshController,
      child: () {
        if (isFetchingDataForFirstTime) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_list.isEmpty && widget.isShowingEmptyState) {
          return getEmptyState();
        } else {
          return widget.listType == ListType.grid
              ? GridView.builder(
                  gridDelegate: widget.gridDelegate ?? const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _list.length,
                  itemBuilder: (ctx, index) {
                    _list[index].index = index;
                    return InkWell(
                        onTap: () {
                          updateSelection(widget.selectionType, index);
                          if (widget.onItemTap != null) {
                            widget.onItemTap!(_list[index], index);
                          }
                        },
                        child: widget.itemBuilder(ctx, _list[index], index));
                  })
              : ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (ctx, index) {
                    _list[index].index = index;
                    return InkWell(
                        onTap: () {
                          updateSelection(widget.selectionType, index);
                          if (widget.onItemTap != null) {
                            widget.onItemTap!(_list[index], index);
                          }
                        },
                        child: widget.itemBuilder(ctx, _list[index], index));
                  });
        }
      }(),
    );
  }

  Future<void> refetchData() async {
    // if (widget.setRequest != null) {
    //   isFetchingDataForFirstTime = true;
    // }
    // setState(() {
    // });
    // await _fetchData();
    _refreshController.requestRefresh(needMove: true);
  }

  Future<void> _fetchData() async {
    Logger.log("_fetchData read");
    if (widget.setRequest != null) {
      if (widget.requestBuilder == null) {
        assert(widget.requestBuilder == null,
            "Request Builder should not be null");
      }
      final request = widget.setRequest!();
      _request = request!;
      final response = await buildRequest();
      await buildData(response);
    } else {
      await buildData(null);
    }
    isFetchingDataForFirstTime = false;
    if (mounted) setState(() {});
  }

  Future<void> _onRefresh() async {
    if (!mounted) return;
    Logger.log("onRefresh");
    _list.clear();
    _list = [];
    currentPage = 1;
    await _fetchData();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoadMore() async {
    currentPage += 1;
    await _fetchData();
    if (_list.length == totalItems) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  Future<void> buildData(BaseResponse? response) async {
    Logger.log("buildData");
    if (widget.responseHandler != null) {
      final data = await widget.responseHandler!(response) ?? [];
      currentPage = response?.pagination?.currentPage?.toInt() ?? 1;
      totalItems = response?.pagination?.totalItems?.toInt() ?? 1;
      for (var i = 0; i < data.length; i++) {
        final item = data[i];
        if (widget.handlingSelection != null) {
          _list.add(widget.handlingSelection!(item, i));
        } else {
          _list.add(BaseListData(object: item, index: i));
        }
      }
      // _list = items;
      Logger.log("Item count ${_list.length}");
      Logger.log("Current Page ${currentPage}");
      Logger.log("Total pages ${totalItems}");
    }

    if (widget.setObjects != null) {
      final data = widget.setObjects!();
      _list = await data;
    }

    if (widget.setData != null) {
      final data = widget.setData!();
      final items = (await data)!;

      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        if (widget.handlingSelection != null) {
          _list.add(widget.handlingSelection!(item, i));
        } else {
          _list.add(BaseListData(object: item, index: i));
        }
      }
    }
  }

  Widget getEmptyState() {
    return widget.emptyState ??
        Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              SvgPicture.asset("general/ic_empty_state.svg".image_),
              MBText(
                widget.emptyStateTitle ?? localization.noDataToShow,
                color: AppColors.grey,
              )
            ],
          ),
        );
  }

  Future<BaseResponse?> buildRequest() async {
    return await requestBuilder
        ?.setRequest(_request!)
        .setPagination(
            page: currentPage, limit: widget.pageSize ?? Constants.pageSize)
        .setOptions(
            showLoader: false, showErrorMessage: widget.showErrorMessage)
        .build();
  }

  void clearSelection() {
    _list.forEach((element) {
      element.isSelected = false;
    });
  }

  void updateSelection(SelectionType type, index) {
    switch (type) {
      case SelectionType.single:
        final oldStatus = _list[index].isSelected;
        clearSelection();
        _list[index].isSelected = !oldStatus;
        setState(() {});
        break;
      case SelectionType.multi:
        final oldStatus = _list[index].isSelected;
        _list[index].isSelected = !oldStatus;
        setState(() {});
        break;
      case SelectionType.toggle:
        if (!_list[index].isSelected) {
          clearSelection();
          _list[index].isSelected = true;
          setState(() {});
        }
        break;
      case SelectionType.none:
        break;
    }
    if (widget.getSelectedObjects != null && type != SelectionType.none) {
      widget.getSelectedObjects!([
        ..._list
            .where((element) => element.isSelected == true)
            .map((item) => item.object)
            .toList()
      ]);
    }
  }
}
