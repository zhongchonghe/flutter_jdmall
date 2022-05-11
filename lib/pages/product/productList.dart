import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/size_fit.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductList();
  }

  _getProductList() async {
    print(widget.arguments!['cid']);
    final res = ProductListModel.fromJson(
        await getProductList(params: widget.arguments));
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("商品列表"),
      ),
      // child: Text("${widget.arguments}"),
      body: Padding(
        padding: EdgeInsets.all(12.px),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 110.px,
                      height: 110.px,
                      child: Image.network(
                        "https://jdmall.itying.com/public/upload/HPi-GL8lrKI2hJKI6DB05_6M.jpg",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "华硕(ASUS) 飞行堡垒FX60VMGTX1060 15.6英寸游戏笔记本电脑"
                                  .fixAutoLines,
                              style: TextStyle(fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 20.px,
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),

                                  //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
                                  ),

                                  child: const Text("4g"),
                                ),
                                Container(
                                  height: 20.px,
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
                                  ),
                                  child: const Text("126"),
                                ),
                              ],
                            ),
                            const Text(
                              "￥990",
                              style: TextStyle(color: Colors.red, fontSize: 16),
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
          itemCount: 10,
        ),
      ),
    );
  }
}
