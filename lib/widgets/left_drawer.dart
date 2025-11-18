import 'package:flutter/material.dart';
import 'package:peakperformance_shop/screens/all_products_list.dart';
import 'package:peakperformance_shop/screens/menu.dart';
import 'package:peakperformance_shop/screens/product_form.dart';
import 'package:peakperformance_shop/screens/products_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // Bagian drawer header
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // biar semua elemen ke tengah
              mainAxisSize: MainAxisSize.min, // biar column nggak maksa tinggi penuh
              children: [
                Text(
                  'Peak Performance Shop',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6), // ganti dari Padding(padding: EdgeInsets.all(10)) biar ga overflow
                Text("Belanja perlengkapan olahraga terbaik di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          // Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Launch Products'),
            // Bagian redirection ke AddProductPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('All Products List'),
            onTap: () {
              // Route to all products list page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AllProductsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder_special_outlined),
            title: const Text('My Products List'),
            onTap: () {
              // Route to user's products page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductsEntryListPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}