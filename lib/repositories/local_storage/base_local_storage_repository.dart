import 'package:hive/hive.dart';

import '../../user_models/product_model.dart';
import 'package:mobile_pos/user_models/models.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<Product> getWishlist(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductFromWishlist(Box box, Product product);
  Future<void> clearWishlist(Box box);
}
