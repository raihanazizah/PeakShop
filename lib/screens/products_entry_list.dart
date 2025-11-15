import 'package:flutter/material.dart';
import 'package:peakperformance_shop/models/product_entry.dart';
import 'package:peakperformance_shop/widgets/left_drawer.dart';
import 'package:peakperformance_shop/screens/product_detail.dart';
import 'package:peakperformance_shop/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:peakperformance_shop/screens/login.dart';

class ProductsEntryListPage extends StatefulWidget {
  const ProductsEntryListPage({super.key});

  @override
  State<ProductsEntryListPage> createState() => _ProductsEntryListPageState();
}

class _ProductsEntryListPageState extends State<ProductsEntryListPage> {
  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    final response =
    await request.get('http://localhost:8000/json/?user_only=true');

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

    // Jika belum login
    if (!request.loggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please login to view your products'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
      ),
      drawer: const LeftDrawer(),

      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          // Loading
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // No data
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                'You have no products yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // List of products
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
