import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/size_fit.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../../api/home.dart';
import '../../model/Recommond.dart';
import '../../model/produtModel.dart';
import '../../model/Swiper.dart';
import '../../utils/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _favorList = [];
  List _recommondList = [];

  bool _loading = false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFousData();
    _getFavorList();
    _getRecommendList();
  }

  // 获取轮播图数据
  _getFousData() async {
    final focuList = SwiperList.fromJson(await getList());
    for (var val in focuList.result!) {
      setState(() {
        var _url = val.pic.toString().toURL;
        _focusData.add(_url);
        _loading = true;
      });
    }
  }

  // 获取猜你喜欢数据
  _getFavorList() async {
    final favorList = ProductModel.fromJson(await getFavorList());
    setState(() {
      _favorList = favorList.result!;
    });
  }

  // 获取热门推荐数据
  _getRecommendList() async {
    final recommondList = RecommendList.fromJson(await getRecommendList());
    setState(() {
      _recommondList = recommondList.result!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(
          height: 10.px,
        ),
        _titleWidget("猜你喜欢"),
        SizedBox(
          height: 5.px,
        ),
        _favorWidget(),
        SizedBox(
          height: 10.px,
        ),
        _titleWidget("热门推荐"),
        _hotWidget()
      ],
    );
  }

  // 轮播图
  Widget _swiperWidget() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: _loading
            ? Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.network(
                    _focusData[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: _focusData.length,
                autoplay: true,
                pagination: new SwiperPagination(),
                // control: new SwiperControl(),
              )
            : Container(),
      ),
    );
  }

  // 标题
  Widget _titleWidget(val) {
    return Container(
      margin: EdgeInsets.only(left: 10.px),
      padding: EdgeInsets.only(left: 10.px),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.red, width: 4.px))),
      child: Text(
        val,
        style: TextStyle(color: Colors.black54, fontSize: 14.px),
      ),
    );
  }

  // 猜你喜欢
  Widget _favorWidget() {
    return Container(
      // width: double.infinity,
      padding: EdgeInsets.all(10.px),
      height: 100.px,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 10.px),
                  width: 80.px,
                  height: 80.px,
                  child: Image.network(
                    (_favorList[index].sPic).toString().toURL,
                    fit: BoxFit.cover,
                  ))
            ],
          );
        },
        itemCount: _favorList.length,
      ),
    );
  }

  // 热门推荐
  Container _hotWidget() {
    return Container(
      // padding: EdgeInsets.all(10.px),
      padding: EdgeInsets.only(left: 10.px, top: 10.px, bottom: 10.px),
      child: Wrap(
        runSpacing: 10.px,
        spacing: 10.px,
        children: [..._recommondList.map((e) => _productListWidget(e))],
      ),
    );
  }

  _productListWidget(e) {
    var itemWidth = (SizeFit.screenWidth! - 20) / 2.px;
    return Container(
      padding: EdgeInsets.all(5.px),
      width: itemWidth,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(233, 233, 233, 0.9))),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1 / 1, //  防止服务器返回的图片比例不一致
                child: Image.network(
                  e.pic.toString().toURL,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 12.px),
            child: Text(
              e.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "￥${e.price}",
                  style: TextStyle(color: Colors.red, fontSize: 18.px),
                ),
                Text(
                  "￥${e.oldPrice}",
                  style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14.px),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
