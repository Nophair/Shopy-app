class HomeModel
{
  late dynamic status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}


class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {

    if (json['banners'] is List) {
      banners = List<BannerModel>.from(
        json['banners'].map((element) => BannerModel.fromJson(element)),
      );
    }

    if (json['products'] is List) {
      products = List<ProductModel>.from(
        json['products'].map((element) => ProductModel.fromJson(element)),
      );
    }
  }
}

class BannerModel
{
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json,)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late dynamic image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}