class SearchProduct {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  int? price;
  String? image;
  String? createdAt;
  String? updatedAt;

  SearchProduct({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.price,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
