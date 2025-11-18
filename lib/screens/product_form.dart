import 'package:flutter/material.dart';
import 'package:peakperformance_shop/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:peakperformance_shop/screens/menu.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  double _price = 0;
  String _description = "";
  String _category = "Apparel";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'Footwear',
    'Jersey',
    'Equipment',
    'Accessories',
    'Apparel',
    'Supplements',
  ];

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && (uri.isAbsolute && uri.hasScheme && uri.hasAuthority);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Products'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // === Name ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Product name cannot be empty!';
                  } else if (value.length < 3) {
                    return 'Product name should contain at leats 3 chars!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Price ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Product price cannot be empty!';
                  }
                  final price = double.tryParse(value);
                  if (price == null) {
                    return 'Product price must be a number!';
                  } else if (price <= 0) {
                    return 'Product price cannot be zero!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Description ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong!';
                  } else if (value.length < 10) {
                    return 'Deskripsi minimal 10 karakter!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Category ===
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                value: _category,
                items: _categories
                    .map((cat) =>
                    DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: 12),

              // === Thumbnail ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL Thumbnail (optional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _thumbnail = value,
                validator: (value) {
                  if (value != null && value.isNotEmpty &&
                      !_isValidUrl(value)) {
                    return 'Masukkan URL yang valid!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Featured ===
              SwitchListTile(
                title: const Text('Tandai sebagai Produk Unggulan'),
                value: _isFeatured,
                onChanged: (val) => setState(() => _isFeatured = val),
              ),

              // === Save button ===
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                      // Kirim ke endpoint Django
                      final response = await request.post(
                        "http://localhost:8000/create-product-flutter/",
                        jsonEncode({
                          "name": _name,
                          "price": _price,
                          "description": _description,
                          "category": _category,
                          "thumbnail": _thumbnail,
                          "is_featured": _isFeatured,
                        }),
                      );

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Product successfully created!")),
                          );

                          // Balik ke halaman home
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Something went wrong, please try again."),
                            ),
                          );
                        }
                      }
                    }
                  },
                child: const Text('Launch Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class ViewProductPage extends StatelessWidget {
  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyProducts = [
      {'name': 'Sepatu Bola Nike', 'price': 1200000},
      {'name': 'Bola Adidas', 'price': 350000},
      {'name': 'Jersey Liverpool', 'price': 499000},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),
      drawer: LeftDrawer(),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const
              Icon(Icons.shopping_bag_outlined),
              title: Text(product['name']),
              subtitle: Text('Rp ${product['price']}'),
            ),
          );
          },
      ),
    );
  }
}*/