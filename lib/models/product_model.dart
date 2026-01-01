class ProductModel {
  bool? status;
  List<Product>? products;

  ProductModel({
    this.status,
    this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  int? id;
  String? name;
  String? image;
  List<String>? categories;
  String? amazonUrl;

  Product({
    this.id,
    this.name,
    this.image,
    this.categories,
    this.amazonUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    amazonUrl: json["amazon_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "amazon_url": amazonUrl,
  };
}
