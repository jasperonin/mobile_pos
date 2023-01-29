import '../../user_models/product_model.dart';
import 'package:mobile_pos/user_models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
