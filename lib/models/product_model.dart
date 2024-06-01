class ProductModel {
  final dynamic id;
  final String title;
  final String description;
  final dynamic price;
  final String category;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
      id: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      price: jsonData['price'],
      category: jsonData['category'],
      image: jsonData['image'],
    );
  }
}


