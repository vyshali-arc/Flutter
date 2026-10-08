import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ProductApp());
}

// ===============================
// PRODUCT MODEL
// ===============================

class Product {
  final int id;
  final String title;
  final double price;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      image: json['image'],
    );
  }
}

// ===============================
// MAIN APP
// ===============================

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product API App',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      home: const ProductPage(),
    );
  }
}

// ===============================
// PRODUCT PAGE
// ===============================

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> products = [];

  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // ===============================
  // FETCH DATA FROM API
  // ===============================

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://fakestoreapi.com/products',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data =
            jsonDecode(response.body);

        final List<Product> loadedProducts =
            data.map((item) {
          return Product.fromJson(item);
        }).toList();

        setState(() {
          products = loadedProducts;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage =
              'Failed to load products.\n'
              'Status Code: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage =
            'Unable to fetch products.\n'
            'Please check your internet connection.';
        isLoading = false;
      });
    }
  }

  // ===============================
  // BUILD
  // ===============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: fetchProducts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: buildBody(),
    );
  }

  // ===============================
  // BODY
  // ===============================

  Widget buildBody() {
    // LOADING
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),

            SizedBox(height: 15),

            Text(
              'Loading products...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    // ERROR
    if (errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.error_outline,
                size: 70,
                color: Colors.red,
              ),

              const SizedBox(height: 15),

              Text(
                errorMessage,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: fetchProducts,

                icon: const Icon(
                  Icons.refresh,
                ),

                label: const Text(
                  'Retry',
                ),
              ),
            ],
          ),
        ),
      );
    }

    // EMPTY DATA
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'No products found.',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    // PRODUCT LIST
    return ListView.builder(
      padding: const EdgeInsets.all(12),

      itemCount: products.length,

      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          product: product,
        );
      },
    );
  }
}

// ===============================
// PRODUCT CARD
// ===============================

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ===============================
            // IMAGE
            // ===============================

            Container(
              width: 100,
              height: 120,

              padding: const EdgeInsets.all(8),

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(12),

                color: Colors.grey.shade100,
              ),

              child: Image.network(
                product.image,

                fit: BoxFit.contain,

                loadingBuilder:
                    (
                      context,
                      child,
                      loadingProgress,
                    ) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                },

                errorBuilder:
                    (
                      context,
                      error,
                      stackTrace,
                    ) {
                  return const Icon(
                    Icons.broken_image,
                    size: 45,
                  );
                },
              ),
            ),

            const SizedBox(width: 15),

            // ===============================
            // PRODUCT DETAILS
            // ===============================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    product.title,

                    maxLines: 2,

                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color:
                          Colors.blue.shade50,

                      borderRadius:
                          BorderRadius.circular(8),
                    ),

                    child: Text(
                      product.category,
                      style: TextStyle(
                        color:
                            Colors.blue.shade700,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '\$${product.price.toStringAsFixed(2)}',

                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

