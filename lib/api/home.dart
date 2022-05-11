import '../service/request.dart';

getList() {
  return HttpRequest.request(
    'api/focus',
  );
}

getFavorList() {
  return HttpRequest.request(
    'api/plist?is_hot=1',
  );
}

getRecommendList() {
  return HttpRequest.request(
    'api/plist?is_best=1',
  );
}

getPcateList(id) {
  return HttpRequest.request(
    'api/pcate?pid=$id',
  );
}

getcategories({Map<String, dynamic>? params}) {
  return HttpRequest.request('api/pcate', params: params);
}

getProductList({Map<String, dynamic>? params}){
  return HttpRequest.request('api/plist', params: params);
}