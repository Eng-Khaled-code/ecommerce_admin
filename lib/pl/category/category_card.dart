import 'package:final_ecommerce_admin/provider/category_provider.dart';
import 'package:flutter/material.dart';
import '../utilities/widgets/input_dialog.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key,
      @required this.category,
      @required this.categoryId,
      this.categoryProvider})
      : super(key: key);
  final String? categoryId;
  final String? category;
  final CategoryProvider? categoryProvider;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(categoryId!),
      onDismissed: (direction) async => categoryProvider!
          .deleteCategory(categoryId: categoryId, name: category),
      child: ListTile(
        onTap: () => updateCategory(context),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              category!,
              style: TextStyle(color: Colors.blue),
            ),
            Divider(
              height: 2.0,
              color: Colors.blue,
            )
          ],
        ),
      ),
      background: dismissibleBackground(),
    );
  }

  updateCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InputDialog(
              title: "Update Category",
              initialValue: category,
              onSave: (value) async {
                Navigator.pop(context);
                await categoryProvider!.updateCategory(
                    categoryId: categoryId, newName: value, oldName: category);
              },
            ));
  }

  Container dismissibleBackground() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red[100], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [Spacer(), Icon(Icons.delete, size: 30)],
      ),
    );
  }
}
