import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';import '../services/database_service.dart';


import '../services/storage_service.dart';
import '/models/models.dart';
import '/screens/screens.dart';
import '/controllers/controllers.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.black,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => NewProductScreen());
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Add a New Product',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, int index) {
                    return SizedBox(
                      height: 210,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product;
  final int index;

  ProductCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.price,
                              min: 0,
                              max: 25,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              onChanged: (value) {
                                productController.updateProductPrice(
                                  index,
                                  product,
                                  value,
                                );
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductPrice(
                                    product, 'price', value);
                              },
                            ),
                          ),
                          Text(
                            '\P${product.price.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'Qty.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.quantity.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              onChanged: (value) {
                                productController.updateProductQuantity(
                                  index,
                                  product,
                                  value.toInt(),
                                );
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductQuantity(
                                  product,
                                  'quantity',
                                  value.toInt(),
                                );
                              },
                            ),
                          ),
                          Text(
                            '${product.quantity.toInt()}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                        SizedBox(
                          height: 30,
                          child:
                          ElevatedButton.icon(
                              onPressed:() {
                                productController.database.deleteProduct(product);
                              },
                              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                              icon: Icon(Icons.delete_outline),
                              label: Text('Delete', style: TextStyle(fontSize: 20),)
                          ),
                        )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}