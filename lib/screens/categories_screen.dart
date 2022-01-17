import 'package:flutter/material.dart';
import '../app_data.dart';
import '../widgets/catogory_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categories_data = Categories_data;
    return GridView(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 7 / 8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: categories_data
          .map(
            (categoryData) => CategoryItem(
              categoryData.id,
              categoryData.title,
              categoryData.imageUrl,
            ),
          )
          .toList(),
    );
  }
}
