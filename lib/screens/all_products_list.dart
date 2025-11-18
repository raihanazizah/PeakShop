import 'package:flutter/material.dart';
import 'package:peakperformance_shop/models/product_entry.dart';
import 'package:peakperformance_shop/widgets/product_entry_card.dart';
import 'package:peakperformance_shop/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:peakperformance_shop/screens/product_detail.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  Future<List<ProductEntry>> fetchAllProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');

    List<ProductEntry> listProducts = [];
    for (var d in response) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
          title: const Text("All Products"),
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchAllProducts(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No products available."),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {
              final product = snapshot.data![index];
              return ProductEntryCard(
                products: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(products: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
