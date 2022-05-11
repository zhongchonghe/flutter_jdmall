import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/tabs/cart.dart';
import 'package:flutter_jd/pages/tabs/category.dart';
import 'package:flutter_jd/pages/tabs/home.dart';
import 'package:flutter_jd/pages/tabs/user.dart';

import '../utils/size_fit.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;

  List<Widget> _pageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    SizeFit.initialize();
    _pageController = new PageController(initialPage: _currentIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text("商城首页"),
        // centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: Container(
        height: 64,
        child: SafeArea(
          child: BottomNavigationBar(
            // enableFeedback:true,
            mouseCursor: MouseCursor.defer,
            selectedFontSize: 10.0,
            unselectedFontSize: 10.0,
            // elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (idx) {
              setState(() {
                _currentIndex = idx;
                _pageController?.jumpToPage(idx);
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "购物车"),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的")
            ],
          ),
        ),
      ),
    );
  }
}
