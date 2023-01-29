import 'package:flutter/foundation.dart';
import 'package:mobile_pos/models/models.dart';
import 'package:mobile_pos/services/database_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final DatabaseService database = DatabaseService();

  var categories = <Categories>[].obs;

  @override
  void onInit() {
    categories.bindStream(database.getCategories());
    super.onInit();
  }

  var newCategory = {}.obs;

  get name => newCategory['imageUrl'];
  get item_name => newCategory['name'];

}