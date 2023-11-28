class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.formJson(json['data']);
  }
}
class HomeDataModel {
  List<BannersModel>? banners = [];
  List<ProductsModel>? products = [];
  HomeDataModel.formJson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element){
      banners?.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element){
      products?.add(ProductsModel.fromJson(element));
    });

  }
}
class BannersModel {
  int? id;
  String? image;
  BannersModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}
class ProductsModel {
  var id;
  var price;
  var oldPrice;
  var discount;
  var image;
  var name;
  bool? favorite;
  bool? cart;
  ProductsModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    favorite = json['in_favorites'];
    cart = json['in_cart'];
  }
}