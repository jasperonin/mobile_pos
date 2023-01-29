import 'package:mobile_pos/models/models.dart';
import 'package:mobile_pos/services/database_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();

  var products = <Products>[].obs;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];
  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductPrice(
      int index,
      Products product,
      double value,
      ) {
    product.price = value;
    products[index] = product;
  }

  void saveNewProductPrice(
      Products product,
      String field,
      double value,
      ) {
    database.updateField(product, field, value);
  }

  void updateProductQuantity(
      int index,
      Products product,
      int value,
      ) {
    product.quantity = value;
    products[index] = product;
  }

  void saveNewProductQuantity(
      Products product,
      String field,
      int value,
      ) {
    database.updateField(product, field, value);
  }
}