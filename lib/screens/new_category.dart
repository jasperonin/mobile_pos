import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos/controllers/category_controller.dart';
import 'package:mobile_pos/models/models.dart';
import 'package:mobile_pos/services/database_service.dart';
import 'package:mobile_pos/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/controllers/controllers.dart';

class CategoryScreen extends StatelessWidget {

  CategoryScreen({Key? key}) : super(key: key);


  final CategoryController categoryController = Get.put(CategoryController());
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  final _textController = TextEditingController();

  String get imageName => 'null';


  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      // 'Milk Tea',
      // 'Soft Drinks',
      // 'Dry Goods',
      // 'Clothing',
      // 'Snacks',
      // 'Meat',
      // 'Vegetables'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Category'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          ImagePicker _picker = ImagePicker();
                          final XFile? _image = await _picker.pickImage(
                              source: ImageSource.gallery);

                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No image was selected.'),
                              ),
                            );
                          }

                          if (_image != null) {
                            await storage.uploadImage(_image);
                            var imageUrl =
                            await storage.getDownloadURL(_image.name);

                            categoryController.newCategory.update(
                                'imageUrl', (_) => imageUrl,
                                ifAbsent: () => imageUrl);
                          }
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Add an Image',
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
              const SizedBox(height: 20),
              const Text(
                'Category Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: ()  {

                      database.addCategory(
                        Categories(
                            name: _textController.text,
                            imageUrl: categoryController.newCategory['imageUrl']
                        )
                      );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
  Row _buildCheckbox(
      String title,
      String name,
      ProductController productController,
      bool? controllerValue,
      ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(
              name,
                  (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }

}