import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/size_fit.dart';

import '../../api/home.dart';
import '../../model/CategoryDetailsModel.dart';
import '../../model/CategoryModel.dart';
import '../../utils/extensions.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;

  final leftWidth = SizeFit.screenWidth! / 4;
  double get rightItemWidth => (SizeFit.screenWidth! - leftWidth - 20.px) / 2;
  double get rightItemHeight => rightItemWidth + 30.px;

  List _categoryList = [];
  List _categoryDetails = [];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
  }

  _getCategories() async {
    final res = Category.fromJson(await getcategories());
    setState(() {
      _categoryList = res.result!;
    });
    await _getDetails();
  }

  _getDetails() async {
    final data = CategoryDetails.fromJson(
        await getcategories(params: {"pid": _categoryList[_selectIndex].sId}));
    setState(() {
      _categoryDetails = data.result!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [leftCategory(), Expanded(flex: 1, child: rightDetails())],
    );
  }

  Widget leftCategory() {
    return Container(
      width: 100.px,
      height: double.infinity,
      // color: Color.fromARGB(255, 187, 108, 134),
      child: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              unitCategory(index),
              Divider(
                height: 1,
              )
            ],
          );
        },
      ),
    );
  }

// 每一项分类
  Widget unitCategory(index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectIndex = index;
          _getDetails();
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 17.px),
        color: _selectIndex == index
            ? Color.fromARGB(227, 239, 241, 241)
            : Colors.white,
        height: 56.px,
        width: double.infinity,
        child: Text(
          _categoryList[index].title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget rightDetails() {
    return Container(
      padding: EdgeInsets.all(10.px),
      height: double.infinity,
      color: Color.fromARGB(227, 239, 241, 241),
      child: GridView.builder(
          itemCount: _categoryDetails.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: rightItemWidth / rightItemHeight,
              mainAxisSpacing: 10.px,
              crossAxisSpacing: 10.px),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/productList',arguments: {"cid":_categoryDetails[index].sId});
              },
              child: Column(children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    _categoryDetails[index].pic.toString().toURL,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 8.px,
                ),
                SizedBox(
                  height: 20.px,
                  child: Text(_categoryDetails[index].title),
                )
              ]),
            );
          }),
    );
  }
}
