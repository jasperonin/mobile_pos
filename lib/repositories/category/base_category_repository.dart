import 'package:mobile_pos/user_models/models.dart';

abstract class BaseCategoryRepository {
  Stream<List<Category>> getAllCategories();
}
