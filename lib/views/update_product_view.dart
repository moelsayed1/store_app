import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_field.dart';

class UpdateProductView extends StatefulWidget {
  const UpdateProductView({super.key});

  static String id = 'UpdateProductView';

  @override
  State<UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  String? productName;

  String? desc;

  num? price;

  String? image;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Update Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 170,
                ),
                CustomTextField(
                  onChanged: (data) {
                    productName = data;
                  },
                  hintText: 'Product Name',
                  labelText: 'Enter Your Product Name',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  onChanged: (data) {
                    desc = data;
                  },
                  hintText: 'Description',
                  labelText: 'Enter Your Description',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  inputType: TextInputType.number,
                  onChanged: (data) {
                    price = num.parse(data);
                  },
                  hintText: 'Price',
                  labelText: 'Enter Your Price',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  onChanged: (data) {
                    image = data;
                  },
                  hintText: 'Image',
                  labelText: 'Enter Your Product Image',
                ),
                const SizedBox(
                  height: 50.0,
                ),
                CustomButton(
                  text: 'Update Product',
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await updateProduct(product);
                      log('success');
                    } catch (e) {
                      log(e.toString());
                    }
                    isLoading = false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ProductModel> updateProduct(ProductModel product) async{
    return await UpdateProductService().updateProduct(
      productId: product.id.toString(),
      title: productName == null ? product.title : productName!,
      description: desc == null ? product.description : desc!,
      price: price == null ? product.price.toString() : price!.toString(),
      category: product.category,
      image: image == null ? product.image : image!,
    );
  }
}
