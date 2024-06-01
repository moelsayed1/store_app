import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class UpdateProductService
{
  Future<ProductModel> updateProduct({
    required String productId,
    required String title,
    required String description,
    required String price,
    required String category,
    required String image,
  }) async {
    Map<String, dynamic> data =
    await Api().put(url: 'https://fakestoreapi.com/products/$productId', body: {
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    });

    return ProductModel.fromJson(data);
  }
}