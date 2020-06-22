import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import '../models/product.dart';
import './product_item.dart';
import 'package:provider/provider.dart';


class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productsProviderObject = Provider.of<ProductsProvider>(context);
    final products = productsProviderObject.items; //items refers to the getter
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20, //left to right
          mainAxisSpacing: 10),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) {
        return ProductItem(
          products[i].id,
          products[i].title,
          products[i].imageUrl,
        );
      },
    );
  }
}
