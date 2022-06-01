abstract class BaseBean{

  bool isOpen = true;
  int index = 0;
  int  getChildSize();
}


class ParentBean extends BaseBean{

  String? title;
  List<ChildBean> childBeans = [];

  @override
  int getChildSize() => childBeans.length;

}


class ChildBean{

  int? childIndex;
  String? childTitle;

}