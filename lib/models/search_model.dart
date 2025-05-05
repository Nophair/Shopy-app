class SearchModel {
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  late List<Product> data;
  late String firstPageUrl;
  late int lastPage;
  late String lastPageUrl;
  late String path;
  late int perPage;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = (json['data'] != null ? List.from(json['data']).map((v) => Product.fromJson(v)).toList() : []);
    firstPageUrl = json['first_page_url'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    total = json['total'];
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'] ?? null;
    discount = json['discount'] ?? null;
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
