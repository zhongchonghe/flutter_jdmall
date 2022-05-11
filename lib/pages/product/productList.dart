import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/size_fit.dart';
import 'package:flutter_jd/widget/loading.dart';
import '../../api/home.dart';
import '../../model/ProductListModel.dart';
import '../../utils/extensions.dart';

class ProductListPage extends StatefulWidget {
  Map<String, dynamic>? arguments;
  ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();

  List _productList = [];

  // 参数
  final Map<String, dynamic> _queryParams = {
    "cid": "",
    "page": 1,
    "pageSize": 10,
    "sort": "price_1 "
  };

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductList();
    _scrollController.addListener(() {
      // print(_scrollController.position.pixels);
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (!loading && _productList.length < 33) {
          _queryParams['page'] += 1;
          _getProductList();
        }
      }
    });
  }

  _getProductList() async {
    setState(() {
      loading = true;
      _queryParams['cid'] = widget.arguments!['cid'];
    });
    final res =
        ProductListModel.fromJson(await getProductList(params: _queryParams));
    setState(() {
      _productList.addAll(res.result!);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置key
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("商品列表"),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_outlined)),
        actions: [Text("")],
      ),

      endDrawer: Drawer(
        child: Container(
          child: Text("实现筛选功能"),
        ),
      ),
      // child: Text("${widget.arguments}"),
      body: Stack(
        children: [
          _productListWidget(),
          _subHeader(),
        ],
      ),
    );
  }

  // 筛选导航
  Positioned _subHeader() {
    return Positioned(
        height: 45.px,
        width: 375.px,
        top: 0,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          width: 375.px,
          height: 45.px,
          child: Row(children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 14.px),
                  ),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "销量",
                    textAlign: TextAlign.center,
                  ),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "价格",
                    textAlign: TextAlign.center,
                  ),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (_scaffoldKey.currentState != null) {
                      _scaffoldKey.currentState!.openEndDrawer();
                    }
                  },
                  child: Text(
                    "筛选",
                    textAlign: TextAlign.center,
                  ),
                ))
          ]),
        ));
  }

// 商品列表
  StatelessWidget _productListWidget() {
    return Container(
            // padding: EdgeInsets.all(12.px),
            padding: EdgeInsets.fromLTRB(12.px, 0, 12.px, 12.px),
            margin: EdgeInsets.only(top: 45.px),
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 110.px,
                          height: 110.px,
                          child: Image.network(
                            _productList[index].pic.toString().toURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // SizedBox(width: 10.px,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 10.px),
                            height: 110.px,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _productList[index]
                                      .title
                                      .toString()
                                      .fixAutoLines,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '￥${_productList[index].price}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 20.px,
                    )
                  ],
                );
              },
              itemCount: _productList.length,
            ),
          );
  }
}
