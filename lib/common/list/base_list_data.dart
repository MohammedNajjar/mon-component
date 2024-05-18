class BaseListData {

  final dynamic object;

  bool isSelected;

  int index;

  BaseListData({this.object, this.isSelected = false, required this.index});

  @override
  String toString() {
    return 'BaseListData(object: $object, isSelected: $isSelected, index: $index)';
  }
}
